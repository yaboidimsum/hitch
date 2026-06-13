//
//  HitchRequestDoneCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestDoneCard: View {
    let data: HitchRequestData
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "flag.pattern.checkered.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .foregroundStyle(.greenBrand)
            
            Text("You've completed the ride with \(data.name)! Payment of \(data.amountSign.prefix)Rp\(data.amount, format: .number) has been transferred to your wallet.")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.greenBrand)
                .multilineTextAlignment(.center)
            
            Button("Close", action: {})
                .font(.headline)
                .foregroundStyle(.greenBrand)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.mutedSlate.opacity(0.2))
                .clipShape(.rect(cornerRadius: 999))
                .glassEffect()
        }
        .padding(40)
    }
}

#Preview {
    HitchRequestDoneCard(data: HitchRequestData(
        name: "Nadya",
        amount: 20000,
        amountSign: .positive,
        fromLocation: "Autograph Tower Level 52",
        toLocation: "McDonald's Salemba Raya",
        status: .success
    ))
}
