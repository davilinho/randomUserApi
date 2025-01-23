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
    }
}
