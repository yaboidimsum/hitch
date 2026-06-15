//
//  HitchCardList.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

/// Data model for a single row in the hitch card list.

struct HitchCardList: View {
    let items: [HitchCardData]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(items.enumerated(), id: \.element.id) { index, item in
                HitchCard(
                    name: item.name,
                    occupation: item.occupation,
                    destination: item.destination,
                    status: item.status,
                    amount: item.amount,
                    amountSign: item.amountSign,
                    imageUrl: item.imageUrl
                )
                .padding(.horizontal, 16)
                .padding(.vertical,12)
                
                if index < items.count - 1 {
                    Rectangle()
                        .fill(.secondary.opacity(0.3))
                        .frame(height: 1)
                }
            }
        }
    }
}

#Preview {
    HitchCardList(
        items: [
            HitchCardData(
                name: "Kanye West",
                occupation: "Driver",
                destination: "McDonald's Salemba Raya",
                status: .inProgress,
                amount: 20000,
                amountSign: .positive,
                imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Kanye"
            ),
            HitchCardData(
                name: "John Doe",
                occupation: "Passenger",
                destination: "Central Park Mall",
                status: .cancelled,
                amount: 20000,
                amountSign: .negative,
                imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=John"
            ),
            HitchCardData(
                name: "Jane Smith",
                occupation: "Passenger",
                destination: "Grand Indonesia",
                status: .success,
                amount: 20000,
                amountSign: .neutral,
                imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Jane"
            )
        ]
    )
}
