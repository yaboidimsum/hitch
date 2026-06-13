//
//  HitchRequestIncomingCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestIncomingCard: View {
    let data: HitchRequestData
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: data.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(.circle)
                .foregroundStyle(.black)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(data.amountSign.prefix)Rp\(data.amount, format: .number)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.greenBrand)
                
                Text(data.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.mutedSlate)
                    .font(.footnote)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text("From:").fontWeight(.semibold)
                        Text(data.fromLocation).fontWeight(.medium)
                    }
                    HStack(spacing: 4) {
                        Text("To:").fontWeight(.semibold)
                        Text(data.toLocation).fontWeight(.medium)
                    }
                }
                .font(.caption2)
            }
            
            HStack(spacing: 4) {
                Button("Reject", systemImage: "xmark", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.greenBrand)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Button("Accept", systemImage: "checkmark", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.greenBrand)
                    .clipShape(.circle)
                    .glassEffect()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    HitchRequestIncomingCard(data: HitchRequestData(
        name: "Nadya",
        amount: 20000,
        amountSign: .positive,
        fromLocation: "Autograph Tower Level 52",
        toLocation: "McDonald's Salemba Raya",
        status: .rideRequest
    ))
}
