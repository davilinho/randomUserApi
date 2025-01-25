//
//  DetailView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 25/1/25.
//

import SwiftUI

struct DetailView: View {
    private let user: UserEntity

    @State private var isInfoVisible = false

    init(user: UserEntity) {
        self.user = user
    }

    var body: some View {
        VStack {
            Spacer()
            if let pictureURL = self.user.pictureURL,
               let url = URL(string: pictureURL) {
                AsyncImage(url: url)
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.4)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            }

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    Text(self.user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.green)
                    Text(self.user.phone ?? "")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            )
            .padding()
            .opacity(self.isInfoVisible ? 1 : 0)
            .offset(y: self.isInfoVisible ? 0 : 50)
            .animation(.easeOut(duration: 0.5), value: self.isInfoVisible)

            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            withAnimation {
                self.isInfoVisible = true
            }
        }
    }
}
