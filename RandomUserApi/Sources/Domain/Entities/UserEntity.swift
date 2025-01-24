//
//  UserEntity.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation
import SwiftData

@Model
final class UserEntity: Hashable, Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var surname: String
    var email: String?
    var phone: String?
    var pictureURL: String?
    var thumbnailURL: String?

    init(id: String,
         name: String,
         surname: String,
         email: String? = nil,
         phone: String? = nil,
         pictureURL: String? = nil,
         thumbnailURL: String? = nil) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.phone = phone
        self.pictureURL = pictureURL
        self.thumbnailURL = thumbnailURL
    }

    static func == (lhs: UserEntity, rhs: UserEntity) -> Bool {
        lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.email == rhs.email
    }
}

extension User {
    var entity: UserEntity {
        UserEntity(id: UUID().uuidString,
                   name: self.name?.first ?? "",
                   surname: self.name?.last ?? "",
                   email: self.email,
                   phone: self.phone,
                   pictureURL: self.picture?.medium,
                   thumbnailURL: self.picture?.thumbnail)
    }
}
