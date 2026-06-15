//
//  FriendCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct FriendCard: View {
    let data: FriendCardData
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: data.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(.gray.opacity(0.3))
            }
            .frame(width: 40, height: 40)
            .clipShape(.circle)
            
            Text(data.name)
                .font(.caption)
                .bold()
                .foregroundStyle(.greenBrand)
            
            Spacer()
            
            Text(data.distance)
                .font(.caption)
                .bold()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    FriendCard(data: FriendCardData(name: "Kanye West", distance: "0.5m"))
}
