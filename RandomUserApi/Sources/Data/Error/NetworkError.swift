//
//  NetworkError.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}
