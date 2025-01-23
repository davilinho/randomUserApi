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
