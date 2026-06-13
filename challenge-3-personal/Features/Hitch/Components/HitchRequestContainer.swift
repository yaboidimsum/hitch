//
//  HitchRequestContainer.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestContainer: View {
    let state: HitchRequestState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hitch Request")
                .fontWeight(.semibold)
                .foregroundStyle(.greenBrand)
            
            switch state {
            case .empty:
                Text("Empty")
                    .fontWeight(.medium)
                    .foregroundStyle(.mutedSlate)
                    .italic()
                
            case .incoming(let data):
                HitchRequestIncomingCard(data: data)
                
            case .inProgress(let data):
                HitchRequestProgressCard(data: data)
                
            case .done(let data):
                HitchRequestDoneCard(data: data)
                
            case .rejected(let data):
                HitchRequestRejectedCard(data: data)
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        HitchRequestContainer(state: .empty)
        
        HitchRequestContainer(state: .incoming(HitchRequestData(
            name: "Nadya",
            amount: 20000,
            amountSign: .positive,
            fromLocation: "Autograph Tower Level 52",
            toLocation: "McDonald's Salemba Raya",
            status: .rideRequest
        )))
        
        HitchRequestContainer(state: .inProgress(HitchRequestData(
            name: "Nadya",
            amount: 20000,
            amountSign: .positive,
            fromLocation: "Autograph Tower Level 52",
            toLocation: "McDonald's Salemba Raya",
            status: .inProgress
        )))
        
        HitchRequestContainer(state: .done(HitchRequestData(
            name: "Nadya",
            amount: 20000,
            amountSign: .positive,
            fromLocation: "Autograph Tower Level 52",
            toLocation: "McDonald's Salemba Raya",
            status: .success
        )))
        
        HitchRequestContainer(state: .rejected(HitchRequestData(
            name: "Nadya",
            amount: 20000,
            amountSign: .positive,
            fromLocation: "Autograph Tower Level 52",
            toLocation: "McDonald's Salemba Raya",
            status: .cancelled
        )))
    }
}
