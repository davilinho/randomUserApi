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
    var usersResponse: UserEntityResponse = UserEntityResponse(entities: []) {
        didSet {
            if self.usersResponse.entities.isEmpty {
                self.viewState = .empty
            } else {
                self.viewState = .results
            }
        }
    }
    var blacklistUsers: [UserEntity] = []

    init(useCase: ListUsersUseCase = DefaultUsersUseCase()) {
        self.useCase = useCase
    }

    func fetchUsers() async {
        do {
            self.viewState = .loading
            self.usersResponse = try await self.useCase.fetchUsers(page: 1, seed: nil)
        } catch {
            self.viewState = .error
        }
    }

    func fetchNextPage() async {
        do {
            if let page = self.usersResponse.info?.page {
                self.nextPage = page + 1
            }
            self.seed = self.usersResponse.info?.seed

            let response = try await self.useCase.fetchUsers(page: self.nextPage, seed: self.seed)

            self.usersResponse.entities.append(contentsOf: response.entities)
        } catch {
            self.viewState = .error
        }
    }
}
