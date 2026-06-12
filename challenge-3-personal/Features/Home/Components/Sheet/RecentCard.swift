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
                    .font(.headline).foregroundStyle(.greenBrand)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.greenBrand)
            }.fontWeight(.semibold)
            VStack {
                RecentItem(name: "Little Olie!", address: "Bendungan Hilir, South Jakarta", showDivider: true)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                RecentItem(name: "Little Olie!", address: "Bendungan Hilir, South Jakarta", showDivider: true)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)

                RecentItem(name: "Little Olie!", address: "Bendungan Hilir, South Jakarta", showDivider: false)
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
