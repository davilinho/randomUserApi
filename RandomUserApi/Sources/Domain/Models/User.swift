//
//  User.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation

struct User: Codable {
    let name: Name?
    let email: String?
    let phone: String?
    let picture: Picture?

    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?
    }

    struct Picture: Codable {
        let large: String?
        let medium: String?
        let thumbnail: String?
    }
}
