//
//  UserRepository.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

protocol UserRepository {
    func fetchUsers(_ resource: Resource<UserResponse>) async throws -> UserResponse
    func fetchBlackListedUsers() throws -> [UserEntity]
    func addToBlacklist(_ user: UserEntity) throws
}

class DefaultUserRepository: UserRepository {
    private let apiClient: APIClient
    private let localStorage: LocalStorage

    @MainActor
    init(apiClient: APIClient = DefaultAPIClient.shared, localStorage: LocalStorage = DefaultLocalStorage.shared) {
        self.apiClient = apiClient
        self.localStorage = localStorage
    }

    func fetchUsers(_ resource: Resource<UserResponse>) async throws -> UserResponse {
        try await self.apiClient.request(resource)
    }

    func fetchBlackListedUsers() throws -> [UserEntity] {
        self.localStorage.fetch()
    }

    func addToBlacklist(_ user: UserEntity) throws {
        try self.localStorage.save(user)
    }
}
