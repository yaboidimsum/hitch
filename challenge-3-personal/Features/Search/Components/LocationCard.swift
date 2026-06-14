//
//  LocationCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct LocationCard: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "clock.fill")
                    .foregroundStyle(.greenBrand)
                    .font(.callout)
                VStack(alignment: .leading ,spacing:8){
                    Text("Apple Developer Academy @ Binus")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.greenBrand)
                    Text(
                        "Jl. Grand Boulevard, BSD Green Office Park 9, BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345, Indonesia"
                    )
                    .font(.caption2)
                    .foregroundStyle(.greenBrand)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
            Rectangle()
                .fill(.mutedSlate.opacity(0.2))
                .frame(height: 1)
    }
}

#Preview{
    LocationCard()
}
