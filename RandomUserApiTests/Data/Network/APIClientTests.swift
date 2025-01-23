//
//  APIClientTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation
import Testing
@testable import RandomUserApi

@Suite struct DefaultAPIClientTests {
    @Suite struct Success {
        @Test func requestWithValidResponseReturnsDecodedData() async throws {
            // Arrange
            let expectedData = TestModel(id: 1, name: "Test")
            let mockData = try JSONEncoder().encode(expectedData)
            let mockURL = URL(string: "https://randomuser.me")!
            let mockResource = Resource<TestModel>(url: mockURL)
            
            let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
            let client = DefaultAPIClient(session: mockSession)
            
            // Act
            let result = try await client.request(mockResource)
            
            // Assert
            #expect(result.id == expectedData.id)
            #expect(result.name == expectedData.name)
        }
    }

    @Suite struct Failure {
        @Test func requestWithDecodingErrorThrowsDecodingError() async {
            // Arrange
            let invalidData = Data("invalid".utf8)
            let mockURL = URL(string: "https://randomuser.me")!
            let mockResource = Resource<TestModel>(url: mockURL)
            
            let mockSession = MockURLSession(data: invalidData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
            let client = DefaultAPIClient(session: mockSession)
            
            // Act & Assert
            do {
                _ = try await client.request(mockResource)
                Issue.record("Expected decodingError, but it succeeded")
            } catch NetworkError.decodingError {
                // Success
            } catch {
                Issue.record("Expected decodingError, but got \(error)")
            }
        }
    }
}

class MockURLSession: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.mockData = data
        self.mockResponse = response
        self.mockError = error
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw NetworkError.invalidResponse
        }
        return (data, response)
    }
}
