//
//  Receipt.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestReceipt: View {
    var body: some View {
        VStack(spacing:20){
            VStack(spacing:12){
                DestinationCard().padding(.vertical,12).padding(.horizontal,16)
                Rectangle()
                    .fill(.mutedSlate.opacity(0.2))
                    .frame(height: 1)
                FriendCard(data:         FriendCardData(name: "Kanye West", distance: "0.5m"),
                )
                
            }
            
            VStack{
                HStack{
                    Text("Price").font(.caption).fontWeight(.semibold)
                    Spacer()
                    Text("Rp20.000").font(.caption).fontWeight(.medium)
                }.padding(.horizontal,16)
                HStack{
                    Text("Tax").font(.caption).fontWeight(.semibold)
                    Spacer()
                    Text("Rp20.000").font(.caption).fontWeight(.medium)
                }.padding(.vertical,12).padding(.horizontal,16)
            }
            Rectangle()
                .fill(.mutedSlate.opacity(0.2))
                .frame(height: 1)
            VStack{
                HStack{
                    Text("Subtotal").font(.caption).fontWeight(.semibold)
                    Spacer()
                    Text("Rp40.000").font(.caption).fontWeight(.medium)
                }.padding(.vertical,12).padding(.horizontal,16)
                HStack{
                    Text("Payment Method").font(.caption).fontWeight(.semibold)
                    Spacer()
                    Text("Apple Pay").font(.caption).fontWeight(.medium)
                }.padding(.vertical,12).padding(.horizontal,16)
            }
            Rectangle()
                .fill(.mutedSlate.opacity(0.2))
                .frame(height: 1)
            VStack{
                Button("Send Request", action: {})
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12).padding(.horizontal,16)
                    .background(.greenBrand)
                    .clipShape(.rect(cornerRadius: 999))
                    .glassEffect()
            }.padding(.vertical,16).padding(.horizontal,12)
            
        }
        
    }
}

#Preview {
    RequestReceipt()
}
