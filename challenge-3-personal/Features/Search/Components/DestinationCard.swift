//
//  DestinationCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct DestinationCard: View {
    @State private var destination = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.greenBrand)
                Text("Autograph Tower Level 52")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.greenBrand)
            }
            
            Rectangle()
                .fill(.mutedSlate.opacity(0.2))
                .frame(height: 1)
                .padding(.leading, 24)
            
            HStack {
                Image(systemName: "flag.pattern.checkered.circle.fill")
                    .font(.caption)
                    .foregroundStyle(.greenBrand)
                TextField("Where to", text: $destination)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.ink)
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
