//
//  ContentViewModel.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftUI

@MainActor
@Observable
class ContentViewModel {
    private var useCase: ListUsersUseCase
    private var page: Int = 1
    private var seed: String?

    var viewState: ViewState = .loading

    var users: [UserEntity] = []
    var filteredUsers: [UserEntity] = []
    var blacklistUsers: [UserEntity] = []

    var info: Info?

    var filterText: String = ""
    private var filterTimer: Timer?

    init(useCase: ListUsersUseCase = DefaultUsersUseCase()) {
        self.useCase = useCase
    }

    func fetchUsers() async {
        do {
            try await self.fetch()
        } catch {
            self.viewState = .error
        }
    }

    func fetchUsersNextPage() async {
        do {
            self.setNextPage()
            self.setSeed()

            try await self.fetch()
        } catch {
            self.viewState = .error
        }
    }

    func needsFetchMore(_ lastVisibleUser: UserEntity) -> Bool {
        lastVisibleUser == self.users.last
    }

    func filter() {
        self.filterTimer?.invalidate()
        self.filterTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            Task { @MainActor in
                defer {
                    self.updateViewState()
                }

                self.filteredUsers = self.users.filter(self.filterText)
                self.filteredUsers.distinct()
                self.filteredUsers.sortByName()
            }
        }
    }
}

// MARK: - Private functions

extension ContentViewModel {
    private func fetch() async throws {
        let response = try await self.useCase.fetchUsers(page: self.page, seed: self.seed)
        self.update(response.entities)
        self.update(response.info)
    }

    private func update(_ users: [UserEntity]) {
        defer {
            self.updateViewState()
        }

        self.users.append(contentsOf: users)
        self.users.distinct()
        self.users.sortByName()
        self.filteredUsers = self.users
    }

    private func update(_ info: Info?) {
        self.info = info
    }

    private func setNextPage() {
        guard let page = self.info?.page, !self.users.isEmpty else {
            self.page = 1
            return
        }
        self.page = page + 1
    }

    private func setSeed() {
        self.seed = self.info?.seed
    }

    private func updateViewState() {
        withAnimation {
            if self.users.isEmpty {
                self.viewState = .loading
            } else if self.filteredUsers.isEmpty {
                self.viewState = .empty
            } else {
                self.viewState = .results
            }
        }
    }
}
