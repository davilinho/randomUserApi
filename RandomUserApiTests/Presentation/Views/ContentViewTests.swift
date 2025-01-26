//
//  ContentViewTests.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 26/1/25.
//

import Testing
import ViewInspector
@testable import RandomUserApi
import SwiftUI

// MARK: - DISCLAIMER:
//          There are some tests on this suite, that're disabled, by a known issue in XCode 16:
//          https://forums.swift.org/t/fatal-error-internal-inconsistency-no-test-reporter-for-test-case-argumentids/75666
//          on this test time, I have'nt been not enought time to find any solution

@Suite struct ContentViewTests {
    @Suite struct Success {
        @Test
        func initialState() async throws {
            Task { @MainActor in
                // Arrange
                let contentView = ContentView()
                let view = try contentView.inspect()

                // Act
                try? await view.callTask()
                try? view.callOnAppear()

                let loadingView = try view.navigationSplitView().view(LoadingView.self)

                // Assert
                #expect(loadingView != nil)
            }
        }

        @Test
        func searchableFilter() async throws {
            Task { @MainActor in
                // Arrange
                let contentView = ContentView()
                let view = try contentView.inspect()

                // Act
                try view.find(ViewType.TextField.self).setInput("John")
                let filterText = try #require(contentView.viewModel.filterText)

                // Assert
                #expect(filterText == "John")
            }
        }

        @Test(.disabled())
        func toolbarPresence() async throws {
            Task { @MainActor in
                // Arrange
                let viewModel = ContentViewModel(blackListUseCase: MockBlacklistUsersUseCase())
                let contentView = ContentView(viewModel: viewModel)
                let view = try contentView.inspect()

                // Act
                try? await view.callTask()
                try? view.callOnAppear()

                // Assert
                #expect(viewModel.hasBlacklistedUsers)
            }
        }
    }
}

class MockBlacklistUsersUseCase: BlacklistUsersUseCase {
    private var testExpectedBlacklistEntity: [UserEntity] = []
    func fetchBlackListedUsers() throws -> [UserEntity] {
        testExpectedBlacklistEntity
    }
    
    func addToBlacklist(_ user: UserEntity) throws {
        testExpectedBlacklistEntity.append(user)
    }
}
