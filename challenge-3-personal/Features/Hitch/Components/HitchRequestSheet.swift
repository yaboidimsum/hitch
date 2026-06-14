//
//  HitchRequestSheet.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestSheet: View {
    var body: some View {
        ScrollView{
            HitchRequestProgressCard(data: HitchRequestData(
                name: "Nadya",
                amount: 20000,
                amountSign: .positive,
                fromLocation: "Autograph Tower Level 52",
                toLocation: "McDonald's Salemba Raya",
                status: .inProgress
            ))
        }
    }
}

#Preview {
    HitchRequestSheet()
}
