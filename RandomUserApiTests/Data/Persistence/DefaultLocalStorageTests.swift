//
//  DefaultLocalStorageTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftData
import Testing
@testable import RandomUserApi

@Suite struct DefaultLocalStorageTests {
    let localStorage = MockLocalStorage()

    @Test func save() throws {
        // Arrange
        let user = self.localStorage.expectedUserEntity

        // Act
        try self.localStorage.save(user)

        // Assert
        #expect(self.localStorage.saveCalled)
    }

    @Test func fetch() throws {
        // Arrange
        let user = self.localStorage.expectedUserEntity

        // Act
        let result: [UserEntity] = self.localStorage.fetch()

        // Assert
        #expect(self.localStorage.fetchCalled)

        #expect(result.count == 1)
        #expect(result.first?.name == user.name)
    }

    @Test func delete() throws {
        // Arrange
        let user = self.localStorage.expectedUserEntity

        // Act
        try self.localStorage.delete(user)

        // Assert
        #expect(self.localStorage.deleteCalled)
    }
}

// MARK: - Mock Classes

class MockLocalStorage: LocalStorage {
    let expectedUserEntity = UserEntity(id: "1", name: "Test", surname: "Surname", email: "email@test.com", phone: "1234567890", pictureURL: "")

    var saveCalled = false
    var fetchCalled = false
    var deleteCalled = false

    func save<T>(_ value: T) throws where T : PersistentModel {
        self.saveCalled = true
    }

    func fetch<T>() -> [T] where T : PersistentModel {
        self.fetchCalled = true
        guard let response = [self.expectedUserEntity] as? [T] else {
            return []
        }
        return response
    }

    func delete<T>(_ value: T) throws where T : PersistentModel {
        self.deleteCalled = true
    }
}
