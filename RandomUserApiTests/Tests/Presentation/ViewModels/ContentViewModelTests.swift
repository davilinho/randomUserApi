//
//  ContentViewModelTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 26/1/25.
//

import Testing
@testable import RandomUserApi

// MARK: - DISCLAIMER:
//          There are some tests on this suite, that're disabled, by a known issue in XCode 16:
//          https://forums.swift.org/t/fatal-error-internal-inconsistency-no-test-reporter-for-test-case-argumentids/75666
//          on this test time, I have'nt been not enought time to find any solution

@Suite struct ContentViewModelTests {
    @Suite struct Success {
        @Test(arguments: [expectedUserEntityResponse])
        func fetchUsersSuccess(expectedUserEntityResponse: UserEntityResponse) async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()
                
                // Arrange
                let users = expectedUserEntityResponse
                
                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsers()

                // Assert
                let isSameCount = mockViewModel.users.count == users.entities.count
                let hasResults = mockViewModel.viewState == .results
                #expect(isSameCount && hasResults)
            }
        }

        @Test(arguments: [expectedUserEntityResponse])
        func fetchUsersNextPageSuccess(expectedUserEntityResponse: UserEntityResponse) async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Arrange
                let users = expectedUserEntityResponse

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsersNextPage()

                // Assert
                let isSameCount = mockViewModel.users.count == users.entities.count
                let hasResults = mockViewModel.viewState == .results
                #expect(isSameCount && hasResults)
            }
        }

        @Test(.disabled(),
              arguments: [expectedUserEntity])
        func needsFetchMoreFetch(expectedUserEntity: UserEntity) async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsers()
                let isNeedsMore = mockViewModel.needsFetchMore(expectedUserEntity)

                // Assert
                #expect(isNeedsMore)
            }
        }

        @Test(.disabled(),
              arguments: [UserEntity(id: "", name: "", surname: "", email: "")])
        func noNeedsFetchMoreFetch(expectedUserEntity: UserEntity) async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsers()
                let isNoNeedsMore = mockViewModel.needsFetchMore(expectedUserEntity)

                // Assert
                #expect(isNoNeedsMore)
            }
        }

        @Test(.disabled(),
              arguments: [String("Test")]
        )
        func fetchFilterSuccess(filterText: String) {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                mockViewModel.filterText = filterText
                mockViewModel.filter()

                // Assert
                #expect(mockViewModel.viewState == .results)
            }
        }

        @Test(.disabled(),
              arguments: [expectedBlacklistEntity])
        func addToBlacklistUser(blacklistUser: UserEntity) async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                mockViewModel.addToBlacklist(blacklistUser)
                mockViewModel.fetchBlacklist()

                // Assert
                #expect(!mockViewModel.blacklistUsers.isEmpty)
            }
        }
    }

    @Suite struct Failure {
        @Test(.disabled())
        func fetchUsersFailure() async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsers()

                // Assert
                let hasNoResults = mockViewModel.viewState == .empty
                #expect(hasNoResults)
            }
        }

        @Test(.disabled())
        func fetchUsersNextPageFailure() async throws {
            Task { @MainActor in
                let mockUseCase = MockListUsersUseCase()

                // Act
                let mockViewModel = ContentViewModel(useCase: mockUseCase)
                await mockViewModel.fetchUsersNextPage()

                // Assert
                let hasNoResults = mockViewModel.viewState == .empty
                #expect(hasNoResults)
            }
        }
    }
}

class MockListUsersUseCase: ListUsersUseCase, @unchecked Sendable {
    func fetchUsers(page: Int, seed: String?) async throws -> UserEntityResponse {
        expectedUserEntityResponse
    }
}
