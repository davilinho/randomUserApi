//
//  BlacklistUsersUseCaseTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Testing
@testable import RandomUserApi

@Suite struct BlacklistUsersUseCaseTests {
    @Suite struct Success {
        @MainActor
        @Test func fetchBlacklistedUsersReturnUserEntityArray() throws {
            let mockRepository = MockBlacklistRepository()

            // Arrange
            let users = [expectedUserEntity]

            // Act
            let mockUseCase = DefaultBlacklistUsersUseCase(repository: mockRepository)
            let entities = try mockUseCase.fetchBlackListedUsers()

            // Assert
            #expect(entities.count == users.count)
            #expect(entities.first == users.first)
        }

        @MainActor
        @Test func addToBlacklistUser() throws {
            let mockRepository = MockBlacklistRepository()

            // Arrange
            let users = [expectedUserEntity]

            // Act
            let mockUseCase = DefaultBlacklistUsersUseCase(repository: mockRepository)
            try mockUseCase.addToBlacklist(UserEntity(id: "9663", name: "Test 2", surname: "Surname 2", email: "", phone: "", pictureURL: ""))

            // Assert
            #expect(users.count == 1)
        }
    }

    @Suite struct Failure {
        @MainActor
        @Test func addToBlacklistUserIsAlreadyUserDuplicated() throws {
            let mockRepository = MockBlacklistRepository()

            // Arrange
            let user = expectedUserEntity

            // Act
            let mockUseCase = DefaultBlacklistUsersUseCase(repository: mockRepository)

            do {
                try mockUseCase.addToBlacklist(user)
                // Assert
                Issue.record("This user is already blacklisted")
            } catch {
                // Success
            }
        }
    }
}

// MARK: - Mock Classes

class MockBlacklistRepository: BlacklistRepository {
    var mockBlacklistedUsers: [UserEntity] = []

    func fetchBlackListedUsers() throws -> [UserEntity] {
        self.mockBlacklistedUsers = [expectedUserEntity]
        return self.mockBlacklistedUsers
    }

    func addToBlacklist(_ user: UserEntity) throws {
        self.mockBlacklistedUsers = [expectedUserEntity]
        self.mockBlacklistedUsers.append(user)
    }
}
