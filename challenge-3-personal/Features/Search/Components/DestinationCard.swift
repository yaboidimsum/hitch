//
//  DestinationCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct DestinationCard: View {
    @State private var destination = ""
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.greenBrand)
                Text("Autograph Tower Level 52")
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
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text("Search for destination")
                            .foregroundStyle(.ink.opacity(0.8))
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    TextField("", text: $searchText)
                        .foregroundStyle(.ink)
                        .font(.caption)
                        .bold()
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.mutedSlate.opacity(0.05))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    DestinationCard()
}
