//
//  Notifaction.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct Notification: View{
    private let items: [HitchCardData] = [
        HitchCardData(
            name: "Kanye West",
            occupation: "Passenger",
            destination: "McDonald's Salemba Raya",
            status: .rideRequest,
            amount: 20000,
            amountSign: .positive
        ),
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HitchCardList(items: items)
            }
            .padding(.vertical, 16)
        }
        .background(.background)
        .navigationTitle("Notification")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview{
    Notification()
}
