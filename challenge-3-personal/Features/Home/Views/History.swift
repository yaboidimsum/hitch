//
//  History.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import SwiftUI


struct History: View{
    private let items: [HitchCardData] = [
        HitchCardData(
            name: "Kanye West",
            occupation: "Passenger",
            destination: "McDonald's Salemba Raya",
            status: .success,
            amount: 20000,
            amountSign: .positive
        ),
        HitchCardData(
            name: "John Doe",
            occupation: "Driver",
            destination: "Central Park Mall",
            status: .success,
            amount: 20000,
            amountSign: .negative
        ),
        HitchCardData(
            name: "Jane Smith",
            occupation: "Passenger",
            destination: "Grand Indonesia",
            status: .cancelled,
            amount:20000,
            amountSign: .neutral
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HitchCardList(items: items)
            }
            .padding(.vertical, 16)
        }
        .background(.background)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.large)
    }
}


#Preview{
    History()
}
