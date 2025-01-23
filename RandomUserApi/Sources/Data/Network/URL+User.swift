//
//  URL+Extension.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation

extension URL {
    private enum Constants {
        // Components
        static let scheme = "https"
        static let host = "randomuser.me"
        static let path = "/api/"

        // Query items
        static let include = "inc"
        static let includeItems = "name,email,picture,phone"
        static let page = "page"
        static let results = "results"
        static let seed = "seed"
        static let resultsByPage = "10"
    }

    static func fetch(page: Int, seed: String) throws -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.path

        components.queryItems = [
            URLQueryItem(name: Constants.include, value: Constants.includeItems),
            URLQueryItem(name: Constants.page, value: String(page)),
            URLQueryItem(name: Constants.results, value: Constants.resultsByPage),
            URLQueryItem(name: Constants.seed, value: seed)
        ]

        guard let url = components.url else {
            throw NetworkError.badUrl
        }

        return url
    }
}

