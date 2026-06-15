//
//  FriendItem.swift
//  challenge-3-personal
//

import SwiftUI

struct FriendItem: View {
    let name: String
    let distance: String
    let imageUrl: String

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.gray.opacity(0.3))
            }
            .frame(width: 80, height: 80)
            .clipShape(.circle)

            VStack(spacing: 4) {
                Text(name)
                    .foregroundStyle(.ink)
                    .font(.caption)
                    .fontWeight(.medium)
                Text(distance)
                    .foregroundStyle(.ink)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    FriendItem(name: "John Doe", distance: "25m", imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=John")
}
