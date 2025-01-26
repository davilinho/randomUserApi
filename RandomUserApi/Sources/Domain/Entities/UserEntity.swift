//
//  UserEntity.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation
import SwiftData

@Model
final class UserEntity: Hashable, Identifiable, @unchecked Sendable {
    @Attribute(.unique) var id: String
    var name: String
    var surname: String
    var email: String
    var phone: String?
    var pictureURL: String?
    var thumbnailURL: String?

    init(id: String,
         name: String,
         surname: String,
         email: String,
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
                   email: self.email ?? "",
                   phone: self.phone,
                   pictureURL: self.picture?.large,
                   thumbnailURL: self.picture?.thumbnail)
    }
}

extension Array where Element == UserEntity {
    mutating func filter(_ value: String) -> [UserEntity] {
        self.reduce(into: [UserEntity]()) { result, element in
            if [element.name,
                element.surname,
                element.email].compactMap(
                    {
                        $0.lowercased()
                            .trimmingCharacters(in: .whitespaces)
                            .replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)
                    }
                ).joined()
                .contains(value.lowercased()
                    .trimmingCharacters(in: .whitespaces)
                    .replacingOccurrences(of: "\\s+", with: "", options: .regularExpression)
                ) {
                result.append(element)
            }
        }
    }
}
