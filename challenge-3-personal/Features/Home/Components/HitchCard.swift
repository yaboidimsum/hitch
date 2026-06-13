//
//  HitchCard.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct HitchCard: View {
    let name: String
    let occupation: String
    let destination: String
    let status: RideStatus
    let amount: Int
    let amountSign: AmountSign
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(.circle)
                    .foregroundStyle(.black)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("\(name) (\(occupation))")
                            .fontWeight(.medium)
                            .foregroundStyle(.mutedSlate)
                        Text(destination)
                            .fontWeight(.semibold)
                            .foregroundStyle(.greenBrand)
                    }
                    .font(.footnote)
                    
                    Text(status.rawValue)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(status.color)
                        .clipShape(.rect(cornerRadius: 999))
                        .fontWeight(.semibold)
                        .font(.caption2)
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                
                
                Text("\(amountSign.prefix)Rp\(amount, format: .number)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(amountSign == .positive ? .greenBrand : .mutedSlate)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    VStack(spacing: 12) {
        HitchCard(
            name: "Kanye West",
            occupation: "Passenger",
            destination: "McDonald's Salemba Raya",
            status: .rideRequest,
            amount: 20000,
            amountSign: .positive
        )
        
        HitchCard(
            name: "John Doe",
            occupation: "Driver",
            destination: "Central Park Mall",
            status: .cancelled,
            amount: 20000,
            amountSign: .negative
        )
        
        HitchCard(
            name: "Jane Smith",
            occupation: "Passenger",
            destination: "Grand Indonesia",
            status: .inProgress,
            amount: 20000,
            amountSign: .neutral
        )
    }
    .padding()
}
