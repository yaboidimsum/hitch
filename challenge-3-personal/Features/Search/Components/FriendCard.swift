//
//  FriendCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct FriendCard: View {
    var body: some View {
        VStack{
            HStack{
                HStack(spacing: 12){
                    Image(systemName:"person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(.circle)
                        .foregroundStyle(.black)
                    
                    Text(
                        "Kanye West"
                    ).font(.caption).fontWeight(.semibold)
                        .foregroundStyle(.greenBrand)
                    
                }
                Spacer()
                Text("0.5m").font(.caption).fontWeight(.semibold)
            }
            
        }.padding(.horizontal, 16)
            .padding(.vertical, 12).clipShape(.rect(cornerRadius: 16))
//        Rectangle()
//            .fill(.mutedSlate.opacity(0.2))
//            .frame(height: 1)
    }
}

#Preview{
    FriendCard()
}
