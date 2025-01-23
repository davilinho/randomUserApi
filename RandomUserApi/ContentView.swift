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
    @State private var users: [User] = []
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(self.users, id: \.name?.first) { user in
                    NavigationLink {
                        Text("DETAIL -> \(user.name)")
                    } label: {
                        Text("\(user.name?.first)")
                    }
                }
                .onDelete(perform: deleteItems)
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
                self.users = response.results
            } catch {
                print(error)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
