//
//  UserRepositoryTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Foundation
import Testing
@testable import RandomUserApi

@Suite struct UserRepositoryTests {
    @Suite struct Success {
        @MainActor
        @Test func requestFetchUsersWithValidResponseReturnsDecodedData() async throws {
            // Arrange
            let expectedData = expectedUserResponse
            let mockData = try JSONEncoder().encode(expectedData)
            let mockURL = URL(string: "https://randomuser.me")!
            let mockResource = Resource<UserResponse>(url: mockURL)

            let mockSession = MockURLSession(data: mockData, response: HTTPURLResponse(url: mockURL, statusCode: 200, httpVersion: nil, headerFields: nil), error: nil)
            let client = DefaultAPIClient(session: mockSession)

            let mockRepository = DefaultUserRepository(apiClient: client)

            Task {
                // Act
                let result = try await mockRepository.fetchUsers(mockResource)
                
                // Assert
                #expect(result.results != nil)
                #expect(result.results.count == 1)
                #expect(result.results.first?.name?.first == expectedUserResponse.results.first?.name?.first)
            }
        }

        @MainActor
        @Test func requestFetchBlackListedUsersReturnsDecodedData() async throws {
            // Arrange
            let expectedData = expectedUserEntity
            let mockLocalStorage = DefaultLocalStorage.shared
            try mockLocalStorage.clear()
            try mockLocalStorage.save(expectedData)

            let mockRepository = DefaultUserRepository(localStorage: mockLocalStorage)

            Task {
                // Act
                let result = try mockRepository.fetchBlackListedUsers()

                // Assert
                #expect(result != nil)
                #expect(result.count == 1)
                #expect(result.first?.name == expectedUserEntity.name)
            }
        }

        @MainActor
        @Test func requestAddToBlacklist() async throws {
            // Arrange
            let expectedData = expectedBlacklistEntity
            let mockLocalStorage = DefaultLocalStorage.shared
            try mockLocalStorage.clear()

            let mockRepository = DefaultUserRepository(localStorage: mockLocalStorage)
            try mockRepository.addToBlacklist(expectedData)

            Task {
                // Act
                let result = try mockRepository.fetchBlackListedUsers()

                // Assert
                #expect(result != nil)
                #expect(result.count == 1)
                #expect(result.first?.name == expectedUserEntity.name)
            }
        }
    }
}
