//
//  RequestPickFriend.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestPickFriend: View {
    private let friends = [
        FriendCardData(name: "Kanye West", distance: "0.5m"),
        FriendCardData(name: "John Doe", distance: "1.2km"),
        FriendCardData(name: "Jane Doe", distance: "2.3km"),
        FriendCardData(name: "Mike Smith", distance: "3.1km"),
        FriendCardData(name: "Sarah Lee", distance: "4.5km"),
        FriendCardData(name: "Tom Brown", distance: "5.0km"),
        FriendCardData(name: "Emily Davis", distance: "6.2km")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                DestinationCard()
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                Rectangle()
                    .fill(.mutedSlate.opacity(0.2))
                    .frame(height: 1)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Who'll picked you up?")
                    .font(.headline)
                    .foregroundStyle(.greenBrand)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(friends) { friend in
                            FriendCard(data: friend)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RequestPickFriend()
}
