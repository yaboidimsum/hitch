//
//  LocationCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct LocationCard: View {
    
    let data: LocationCardData
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: data.historyImage)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.greenBrand)
                    .font(.callout)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(data.mainAddress)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.greenBrand)
                    Text(data.subAddress
                    )
                    .font(.caption2)
                    .foregroundStyle(.greenBrand)
                }.frame(width: .infinity)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            Rectangle()
                .fill(.mutedSlate.opacity(0.2))
                .frame(height: 1)
        }.frame(width: .infinity)
            
    }
}

#Preview{
    LocationCard(
        data:LocationCardData(
            mainAddress:"Apple Developer Academy @ Binus",
            subAddress: "Jl. Grand Boulevard, BSD Green Office Park 9, BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345, Indonesia"
        )
    )
}
