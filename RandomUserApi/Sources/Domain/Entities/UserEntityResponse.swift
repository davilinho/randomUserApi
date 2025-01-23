//
//  UserEntityResponse.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

class UserEntityResponse: @unchecked Sendable {
    var entities: [UserEntity] = []

    init(entities: [UserEntity]) {
        self.entities = entities
    }
}
