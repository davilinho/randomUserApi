//
//  UserEntityResponse.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

class UserEntityResponse: @unchecked Sendable {
    var entities: [UserEntity] = []
    var info: Info?

    init(entities: [UserEntity], info: Info? = nil) {
        self.entities = entities
        self.info = info
    }
}

extension Array where Element == UserEntity {
    mutating func distinct() {
        self = self.reduce(into: [UserEntity]()) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }

    mutating func sortByName() {
        self.sort { $0.name.first ?? Character(" ") < $1.name.first ?? Character(" ") }
    }
}
