//
//  ContentView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var users: [UserEntity] = []

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(self.users, id: \.id) { user in
                    NavigationLink {
                        Text("DETAIL -> \(user.name)")
                    } label: {
                        Text("\(user.surname), \(user.name)")
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {

                    } label: {
                        Text("Blacklist")
                    }
                }
            }
            .searchable(text: .constant(""))
            .navigationTitle("Random User API")
        } detail: {

        }
        .task {
            do {
                let resource = try UserResponse.get(page: 1)
                let response = try await DefaultAPIClient().request(resource)
                self.users = response.results.compactMap { $0.entity }
            } catch {
                print(error)
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserEntity.self, inMemory: true)
}
