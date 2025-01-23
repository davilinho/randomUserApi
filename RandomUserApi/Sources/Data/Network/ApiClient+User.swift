//
//  ApiClient+User.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
    let info: Info

    static func get(page: Int, seed: String? = nil) throws -> Resource<UserResponse> {
        guard let url = try URL.fetch(page: page, seed: seed ?? generateRandomSeek), page > 0 else {
            throw NetworkError.badUrl
        }
        return Resource(url: url)
    }

    static var generateRandomSeek: String {
        String((0..<16).compactMap { _ in "0123456789abcdef".randomElement() })
    }
}
