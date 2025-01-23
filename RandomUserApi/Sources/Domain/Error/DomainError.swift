//
//  DomainError.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

enum DomainError: Error {
    case notFound
    case invalidOperation(String)
}
