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
    private var nextPage: Int = 1
    private var seed: String?

    var viewState: ViewState = .loading
    var users: [UserEntity] = [] {
        didSet {
            if self.users.isEmpty {
                self.viewState = .empty
            } else {
                self.viewState = .results
            }
        }
    }
    var info: Info?
    var blacklistUsers: [UserEntity] = []

    init(useCase: ListUsersUseCase = DefaultUsersUseCase()) {
        self.useCase = useCase
    }

    func fetchUsers() {
        Task {
            do {
                self.setNextPage()
                self.setSeed()
                
                try await self.fetchNextPage()
            } catch {
                self.viewState = .error
            }
        }
    }

    func needsFetchMore(_ lastVisibleUser: UserEntity) -> Bool {
        lastVisibleUser == self.users.last
    }
}

// MARK: - Private functions

extension ContentViewModel {
    private func fetchNextPage() async throws {
        let response = try await self.useCase.fetchUsers(page: self.nextPage, seed: self.seed)
        self.append(response.entities)
        self.update(response.info)
    }

    private func append(_ users: [UserEntity]) {
        self.users.append(contentsOf: users)
    }

    private func update(_ info: Info?) {
        self.info = info
    }

    private func setNextPage() {
        guard let page = self.info?.page else {
            self.nextPage = 1
            return
        }
        self.nextPage = page + 1
    }

    private func setSeed() {
        self.seed = self.info?.seed
    }
}
