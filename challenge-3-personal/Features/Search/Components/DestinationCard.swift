//
//  DestinationCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct DestinationCard: View {
//    let currentLocation: String?
    let selectedPlace: Place?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.greenBrand)
                Text("Autograph Tower level 52")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.ink)
            }
            
            Rectangle()
                .fill(.mutedSlate.opacity(0.3))
                .frame(height: 2)
                .padding(.leading, 24)
            
            HStack {
                Image(systemName: "flag.pattern.checkered.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.greenBrand)
                Text(selectedPlace?.name ?? "Select a destination")
                    .font(.caption)
                    .foregroundStyle(.ink.opacity(0.8))
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.mutedSlate.opacity(0.05))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    let store = AppStore.mock()
    DestinationCard(selectedPlace: store.recentPlaces[0])
}
