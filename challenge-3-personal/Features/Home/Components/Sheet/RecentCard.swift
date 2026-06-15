//
//  RecentCard.swift
//  challenge-3-personal
//

import SwiftUI

struct RecentCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            HStack(spacing: 8) {
                Text("Recents")
                    .font(.headline).foregroundStyle(.ink)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.ink)
            }.fontWeight(.semibold)
            VStack {
                RecentItem(name: "Autograph Tower", address: "Thamrin, Jakarta Pusat", showDivider: true, iconName: "building.2.fill")
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                RecentItem(name: "Grand Indonesia", address: "Menteng, Jakarta Pusat", showDivider: true, iconName: "bag.fill")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)

                RecentItem(name: "Gelora Bung Karno", address: "Senayan, Jakarta Pusat", showDivider: false, iconName: "sportscourt.fill")
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
            }
            .background(.background)
            .clipShape(.rect(cornerRadius: 26))
            .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 4)
        }.padding(.horizontal,16)
 
    }
}

#Preview {
    RecentCard()
}
