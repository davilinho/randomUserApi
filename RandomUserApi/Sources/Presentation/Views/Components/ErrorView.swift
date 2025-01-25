//
//  ErrorView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 25/1/25.
//

import SwiftUI

struct ErrorView: View {
    @Environment(ContentViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = self.viewModel

        if viewModel.filterText.count >= 3 {
            ZStack(alignment: .bottomTrailing) {
                Image("background", bundle: .main)
                    .resizable()
                    .scaledToFit()

                Text("Ups! An error occurred")
                    .font(.title)
                    .bold()
                    .padding()
            }
        }
    }
}
