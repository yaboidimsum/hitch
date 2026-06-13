//
//  HitchRequestProgressCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestProgressCard: View {
    let data: HitchRequestData
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Go pick em!").fontWeight(.semibold)
            
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
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .clipShape(.rect(cornerRadius: 16))
            
            Button("Cancel Request", action: {})
                .font(.headline)
                .foregroundStyle(.greenBrand)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.mutedSlate.opacity(0.2))
                .clipShape(.rect(cornerRadius: 999))
                .glassEffect()
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 40)
    }
}

#Preview {
    HitchRequestProgressCard(data: HitchRequestData(
        name: "Nadya",
        amount: 20000,
        amountSign: .positive,
        fromLocation: "Autograph Tower Level 52",
        toLocation: "McDonald's Salemba Raya",
        status: .inProgress
    ))
}
