//
//  LocalStorage.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftData

protocol LocalStorage {
    func save<T>(_ value: T) throws where T : PersistentModel
    func fetch<T>() -> [T] where T : PersistentModel
    func delete<T>(_ value: T) throws where T : PersistentModel
}

class DefaultLocalStorage: LocalStorage {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = DefaultLocalStorage()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: UserEntity.self,
                                                  configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }

    func save<T>(_ value: T) throws where T : PersistentModel {
        self.modelContext.insert(value)
        do {
            try self.modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetch<T>() -> [T] where T : PersistentModel {
        (try? self.modelContext.fetch(FetchDescriptor<T>())) ?? []
    }

    func delete<T>(_ value: T) throws where T : PersistentModel {
        self.modelContext.delete(value)
        try self.modelContext.save()
    }
}
