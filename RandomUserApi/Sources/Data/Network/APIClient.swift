//
//  APIClient.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation

protocol APIClient {
    func request<T: Decodable & Sendable>(_ resource: Resource<T>) async throws -> T
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

class DefaultAPIClient: APIClient {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable & Sendable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.allHTTPHeaderFields = resource.headers

        switch resource.method {
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .get:
            let components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            guard let url = components?.url else {
                throw NetworkError.badUrl
            }
            request = URLRequest(url: url)
        }

        let (data, response) = try await self.session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }

        return result
    }
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = ["Content-Type": "application/json"]
    var method: HttpMethod = .get
}

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}
