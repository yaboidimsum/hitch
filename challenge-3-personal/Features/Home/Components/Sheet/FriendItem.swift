//
//  FriendItem.swift
//  challenge-3-personal
//

import SwiftUI

struct FriendItem: View {
    let name: String
    let distance: String
    let imageName: String

    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(.circle)

            VStack(spacing: 4) {
                Text(name)
                    .foregroundStyle(.greenBrand)
                    .font(.caption)
                    .fontWeight(.medium)
                Text(distance)
                    .foregroundStyle(.greenBrand)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    FriendItem(name: "John Doe", distance: "25m", imageName: "person.fill")
}
