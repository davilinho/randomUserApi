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
}
