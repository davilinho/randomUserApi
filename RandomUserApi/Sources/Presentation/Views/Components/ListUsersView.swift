//
//  ListUsersView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftUI

struct ListUsersView: View {
    @Environment(ContentViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = self.viewModel

        List {
            ForEach(viewModel.filteredUsers, id: \.id) { user in
                NavigationLink {
                    DetailView(user: user)
                        .navigationTitle([user.name, user.surname].joined(separator: " "))
                } label: {
                    UserRowView(user: user)
                        .task {
                            guard viewModel.needsFetchMore(user) else { return }
                            await viewModel.fetchUsersNextPage()
                        }
                }
            }
            .onDelete(perform: self.deleteItems)
        }
        .listStyle(.plain)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                self.viewModel.addToBlacklist(self.viewModel.users[index])
            }
        }
    }
}
