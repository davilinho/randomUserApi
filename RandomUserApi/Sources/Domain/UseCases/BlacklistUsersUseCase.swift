//
//  BlacklistUsersUseCase.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

@MainActor
protocol BlacklistUsersUseCase {
    func fetchBlackListedUsers() throws -> [UserEntity]
    func addToBlacklist(_ user: UserEntity) throws
}

class DefaultBlacklistUsersUseCase: BlacklistUsersUseCase {
    private let repository: BlacklistRepository

    init(repository: BlacklistRepository = DefaultBlacklistRepository()) {
        self.repository = repository
    }

    func fetchBlackListedUsers() throws -> [UserEntity] {
        let entities = try self.repository.fetchBlackListedUsers()

        if entities.isEmpty {
            throw DomainError.notFound
        }

        return entities
    }

    func addToBlacklist(_ user: UserEntity) throws {
        do {
            let currentBlacklistedUsers = try self.fetchBlackListedUsers()

            if currentBlacklistedUsers.contains(where: { $0 == user }) {
                throw DomainError.invalidOperation("This user is already blacklisted")
            }

            try self.repository.addToBlacklist(user)
        } catch {
            switch error {
            case DomainError.notFound:
                try self.repository.addToBlacklist(user)
            default:
                throw error
            }
        }
    }
}
