//
//  ListUsersUseCaseTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import Testing
@testable import RandomUserApi

@Suite struct ListUsersUseCaseTests {
    @Test func fetchUsersReturnUserEntityArray() async throws {
        Task {
            let mockRepository = MockUserRepository()

            // Arrange
            let users = expectedUserEntityResponse

            // Act
            let mockUseCase = DefaultUsersUseCase(repository: mockRepository)
            let entities = try await mockUseCase.fetchUsers(page: 1, seed: "")

            // Assert
            #expect(await entities.entities.count == users.entities.count)
        }
    }
}

// MARK: - Mock Classes

class MockUserRepository: UserRepository {
    var mockBlacklistedUsers: [UserEntity] = []

    func fetchUsers(_ resource: Resource<UserResponse>) async throws -> UserResponse {
        expectedUserResponse
    }
}
