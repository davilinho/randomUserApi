//
//  LoadingView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
                .position(CGPoint(x:  UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2))
        }
        .transition(.opacity)
        .animation(.easeInOut, value: true)
        .ignoresSafeArea()
    }
}
