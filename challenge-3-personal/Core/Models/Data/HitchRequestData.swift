//
//  HitchRequestData.swift
//  challenge-3-personal
//

import Foundation

struct HitchRequestData: Identifiable {
    let id = UUID()
    let name: String
    let amount: Int
    let amountSign: AmountSign
    let fromLocation: String
    let toLocation: String
    let status: RideStatus
    let profileImage: String
    
    init(
        name: String,
        amount: Int,
        amountSign: AmountSign,
        fromLocation: String,
        toLocation: String,
        status: RideStatus,
        profileImage: String = "https://api.dicebear.com/10.x/lorelei/png?seed=Nadya"
    ) {
        self.name = name
        self.amount = amount
        self.amountSign = amountSign
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.status = status
        self.profileImage = profileImage
    }
}
