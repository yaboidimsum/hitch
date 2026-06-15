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
    let imageUrl: String
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(.gray.opacity(0.3))
                }
                .frame(width: 64, height: 64)
                .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("\(name) (\(occupation))")
                            .fontWeight(.medium)
                            .foregroundStyle(.ink.opacity(0.8))
                        Text(destination)
                            .fontWeight(.semibold)
                            .foregroundStyle(.ink)
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
                        .glassEffect()
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                
                
                Text("\(amountSign.prefix)Rp\(amount, format: .number)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(amountSign == .positive ? .greenBrand : .ink.opacity(0.8))
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
            amountSign: .positive,
            imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Kanye"
        )
        
        HitchCard(
            name: "John Doe",
            occupation: "Driver",
            destination: "Central Park Mall",
            status: .cancelled,
            amount: 20000,
            amountSign: .negative,
            imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=John"
        )
        
        HitchCard(
            name: "Jane Smith",
            occupation: "Passenger",
            destination: "Grand Indonesia",
            status: .inProgress,
            amount: 20000,
            amountSign: .neutral,
            imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Jane"
        )
    }
    .padding()
}
