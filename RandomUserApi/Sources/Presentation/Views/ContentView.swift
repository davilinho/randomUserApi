//
//  ContentView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {

                    } label: {
                        Text("Blacklist")
                    }
                }
            }
            .searchable(text: $viewModel.filterText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Write here to filter results...")
            .navigationTitle("Random User API")
            .environment(viewModel)
        } detail: {
            Text("Select a user to see more details")
                .font(.title)
        }
        .task {
            await viewModel.fetchUsers()
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
