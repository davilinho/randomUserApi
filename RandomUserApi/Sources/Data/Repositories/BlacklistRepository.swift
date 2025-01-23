//
//  BlacklistRepository.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

@MainActor
protocol BlacklistRepository {
    func fetchBlackListedUsers() throws -> [UserEntity]
    func addToBlacklist(_ user: UserEntity) throws
}

class DefaultBlacklistRepository: BlacklistRepository {
    private let localStorage: LocalStorage

    init(localStorage: LocalStorage = DefaultLocalStorage()) {
        self.localStorage = localStorage
    }

    func fetchBlackListedUsers() throws -> [UserEntity] {
        self.localStorage.fetch()
    }

    func addToBlacklist(_ user: UserEntity) throws {
        try self.localStorage.save(user)
    }
}
