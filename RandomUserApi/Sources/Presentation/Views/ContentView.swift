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
                    List {
                        ForEach(viewModel.usersResponse.entities, id: \.id) { user in
                            NavigationLink {
                                Text("DETAIL -> \(user.name)")
                            } label: {
                                Text("\(user.surname), \(user.name)")
                            }
                        }
                        //                .onDelete(perform: deleteItems)
                    }
                case .empty:
                    Text("No results")
                case .error:
                    Text("Error")
                }
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
            await viewModel.fetchUsers()
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
