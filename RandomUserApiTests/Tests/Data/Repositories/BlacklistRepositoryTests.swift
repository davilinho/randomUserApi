//
//  BlacklistRepositoryTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation
import Testing
@testable import RandomUserApi

@Suite struct BlacklistRepositoryTests {
    @Suite struct Success {
        @MainActor
        @Test func requestFetchBlackListedUsersReturnsDecodedData() async throws {
            // Arrange
            let expectedData = expectedUserEntity
            let mockLocalStorage = DefaultLocalStorage()
            try mockLocalStorage.clear()
            try mockLocalStorage.save(expectedData)

            let mockRepository = DefaultBlacklistRepository(localStorage: mockLocalStorage)

            Task {
                // Act
                let result = try mockRepository.fetchBlackListedUsers()

                // Assert
                #expect(result.count == 1)
            }
        }

        @MainActor
        @Test func requestAddToBlacklist() async throws {
            // Arrange
            let expectedData = expectedBlacklistEntity
            let mockLocalStorage = DefaultLocalStorage()
            try mockLocalStorage.clear()

            let mockRepository = DefaultBlacklistRepository(localStorage: mockLocalStorage)
            try mockRepository.addToBlacklist(expectedData)

            Task {
                // Act
                let result = try mockRepository.fetchBlackListedUsers()

                // Assert
                #expect(result.count == 1)
            }
        }
    }
}
