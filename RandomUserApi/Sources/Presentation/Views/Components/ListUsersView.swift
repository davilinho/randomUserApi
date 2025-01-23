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
        List {
            ForEach(self.viewModel.usersResponse.entities, id: \.id) { user in
                NavigationLink {
                    Text("DETAIL -> \(user.name)")
                } label: {
                    UserRowView(user: user)
                        .task {
                            if user == self.viewModel.usersResponse.entities.last {
                                await self.viewModel.fetchNextPage()
                            }
                        }
                }
            }
            //                .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
    }

    func fetchNextPage() {

    }
}
