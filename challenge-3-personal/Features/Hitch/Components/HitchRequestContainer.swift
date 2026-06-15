//
//  HitchRequestContainer.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 13/06/26.
//

import SwiftUI

struct HitchRequestContainer: View {
    let state: HitchRequestState
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.ink)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Spacer()
                Text("Hitch Request")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Circle().frame(width: 44, height: 44).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            ScrollView {
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
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    VStack() {
        HitchRequestContainer(state: .empty, onBack: {})
        
//        HitchRequestContainer(state: .incoming(HitchRequestData(
//            name: "Nadya",
//            amount: 20000,
//            amountSign: .positive,
//            fromLocation: "Autograph Tower Level 52",
//            toLocation: "McDonald's Salemba Raya",
//            status: .rideRequest
//        )), onBack: {})
//        
//        HitchRequestContainer(state: .inProgress(HitchRequestData(
//            name: "Nadya",
//            amount: 20000,
//            amountSign: .positive,
//            fromLocation: "Autograph Tower Level 52",
//            toLocation: "McDonald's Salemba Raya",
//            status: .inProgress
//        )), onBack: {})
//        
//        HitchRequestContainer(state: .done(HitchRequestData(
//            name: "Nadya",
//            amount: 20000,
//            amountSign: .positive,
//            fromLocation: "Autograph Tower Level 52",
//            toLocation: "McDonald's Salemba Raya",
//            status: .success
//        )), onBack: {})
//        
//        HitchRequestContainer(state: .rejected(HitchRequestData(
//            name: "Nadya",
//            amount: 20000,
//            amountSign: .positive,
//            fromLocation: "Autograph Tower Level 52",
//            toLocation: "McDonald's Salemba Raya",
//            status: .cancelled
//        )), onBack: {})
    }
}
