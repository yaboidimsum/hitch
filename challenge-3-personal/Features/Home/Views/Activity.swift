//
//  Activity.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI

struct Activity: View {
    private let items: [HitchCardData] = [
        HitchCardData(
            name: "Kanye West",
            occupation: "Passenger",
            destination: "McDonald's Salemba Raya",
            status: .inProgress,
            amount: 20000,
            amountSign: .positive
        ),
        HitchCardData(
            name: "Kanye West",
            occupation: "Driver",
            destination: "McDonald's Salemba Raya",
            status: .inProgress,
            amount: 20000,
            amountSign: .negative
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
        .navigationTitle("Activity")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    Activity()
}
