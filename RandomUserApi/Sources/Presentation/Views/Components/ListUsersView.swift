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
            ForEach(viewModel.users, id: \.id) { user in
                NavigationLink {
                    Text("DETAIL -> \(user.name)")
                } label: {
                    UserRowView(user: user)
                        .task {
                            guard viewModel.needsFetchMore(user) else { return }
                            viewModel.fetchUsers()
                        }
                }
            }
            //                .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }
}
