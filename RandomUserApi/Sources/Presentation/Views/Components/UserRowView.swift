//
//  UserRowView.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 23/1/25.
//

import SwiftUI

struct UserRowView: View {
    var user: UserEntity

    var body: some View {
        HStack {
            if let thumbnail = self.user.thumbnailURL,
               let url = URL(string: thumbnail) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                    case .empty:
                        ProgressView()
                            .padding()
                            .frame(width: 52, height: 52)
                            .background(Color.gray.opacity(0.7))
                            .clipShape(Circle())
                    case .failure:
                        Image(systemName: "xmark.icloud")
                            .frame(width: 52, height: 52)
                            .background(Color.gray.opacity(0.7))
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("\(self.user.name) \(self.user.surname)")
                    .font(.headline)
                    .bold()
                if let email = self.user.email {
                    Text(email)
                        .font(.body)
                }
                if let phone = self.user.phone {
                    Text(phone)
                        .font(.body)
                }
            }
            .lineLimit(1)
            .truncationMode(.tail)
        }
    }
}
