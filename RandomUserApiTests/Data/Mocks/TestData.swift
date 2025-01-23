//
//  TestData.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation

nonisolated(unsafe) let expectedUserEntity = UserEntity(id: "1",
                                                        name: "Test",
                                                        surname: "Surname",
                                                        email: "email@test.com",
                                                        phone: "1234567890",
                                                        pictureURL: "")

let expectedUser = User(name: User.Name(title: "Mr",
                                        first: "Test",
                                        last: "Surname"),
                        email: "email@test.com",
                        phone: "1234567890",
                        picture: nil)

let expectedUserResponse = UserResponse(results: [expectedUser])

nonisolated(unsafe) let expectedBlacklistEntity = UserEntity(id: "999",
                                                             name: "Black",
                                                             surname: "List",
                                                             email: "black@list.com",
                                                             phone: "0987654321",
                                                             pictureURL: "")

struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}
