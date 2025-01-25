//
//  BlacklistView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 25/1/25.
//

import SwiftUI

struct BlacklistView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        @Bindable var viewModel = self.viewModel

        List {
            ForEach(viewModel.blacklistUsers, id: \.id) { user in
                UserRowView(user: user)
            }
        }
        .onAppear {
            viewModel.fetchBlacklist()
        }
    }
}
