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
        let response = try await self.repository.fetchUsers(resource)
        let entities = response.results.compactMap { $0.entity }
        let info = response.info

        if entities.isEmpty {
            throw DomainError.notFound
        }

        let uniqueEntities = Array(Set(entities))
        return UserEntityResponse(entities: uniqueEntities, info: info)
    }
}
