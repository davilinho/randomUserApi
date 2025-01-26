//
//  ContentView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()

    var body: some View {
        @Bindable var viewModel = self.viewModel

        NavigationSplitView {
            ZStack {
                switch viewModel.viewState {
                case .loading:
                    LoadingView()
                case .results:
                    ListUsersView()
                case .empty:
                    EmptyView()
                case .error:
                    ErrorView()
                }
            }
            .privacySensitive()
            .toolbar {
                if viewModel.hasBlacklistedUsers {
                    self.toolbar
                }
            }
            .searchable(text: $viewModel.filterText,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Write here to filter results...")
            .navigationTitle("Random User API")
            .environment(viewModel)
        } detail: {
            Text("Select a user to see more details")
                .font(.title)
        }
        .accentColor(.black)
        .task {
            await viewModel.fetchUsers()
        }.onAppear {
            viewModel.fetchBlacklist()
        }
        .refreshable {
            await viewModel.fetchUsers()
        }
        .onChange(of: viewModel.filterText) { oldValue, newValue in
            Task {
                guard oldValue != newValue, newValue.count >= 3 else {
                    await viewModel.fetchUsers()
                    return
                }
                viewModel.filter()
            }
        }
    }
}

extension ContentView {
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                BlacklistView()
                    .navigationTitle("Black List Users")
            } label: {
                Text("Black List Users")
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    ContentView()
}
