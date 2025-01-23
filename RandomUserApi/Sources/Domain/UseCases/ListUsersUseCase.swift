//
//  ListUsersUseCase.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

protocol ListUsersUseCase: Sendable {
    func fetchUsers(page: Int, seed: String?) async throws -> UserEntityResponse
}

class DefaultUsersUseCase: ListUsersUseCase, @unchecked Sendable {
    private let repository: UserRepository

    init(repository: UserRepository = DefaultUserRepository()) {
        self.repository = repository
    }

    func fetchUsers(page: Int, seed: String?) async throws -> UserEntityResponse {
        let resource = try UserResponse.get(page: page, seed: seed)
        let entities = try await self.repository.fetchUsers(resource).results
            .compactMap { $0.entity }

        if entities.isEmpty {
            throw DomainError.notFound
        }

        let uniqueEntities = Array(Set(entities))
        return await UserEntityResponse(entities: uniqueEntities)
    }
}
