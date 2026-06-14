//
//  RequestPickFriend.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestPickFriend: View {
    var body: some View {
        VStack(spacing:20){
            VStack{
                DestinationCard().padding(.vertical,12).padding(.horizontal,16)
                Rectangle()
                    .fill(.mutedSlate.opacity(0.2))
                    .frame(height: 1)
            }
            VStack(alignment: .leading, spacing:20){
                Text("Who'll picked you up?")
                    .font(.headline)
                    .foregroundStyle(.greenBrand)
                    .padding(.horizontal,16)
                ScrollView{
                    FriendCard()
                    FriendCard()
                    FriendCard()
                    FriendCard()
                    FriendCard()
                    FriendCard()
                    FriendCard()
                }
            }
        }
    }
}

#Preview {
    RequestPickFriend()
}
