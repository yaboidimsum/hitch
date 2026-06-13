//
//  HitchCardData.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 12/06/26.
//

import Foundation

class HitchCardData: Identifiable {
    let id = UUID()
    let name: String
    let occupation: String
    let destination: String
    let status: RideStatus
    let amount: Int
    let amountSign: AmountSign
    
    init(
        name: String,
        occupation: String,
        destination: String,
        status: RideStatus,
        amount: Int,
        amountSign: AmountSign
    ) {
        self.name = name
        self.occupation = occupation
        self.destination = destination
        self.status = status
        self.amount = amount
        self.amountSign = amountSign
    }
}
