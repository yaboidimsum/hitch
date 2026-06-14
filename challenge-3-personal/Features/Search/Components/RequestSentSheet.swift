//
//  RequestSent.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct RequestSentSheet: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .foregroundStyle(.greenBrand)
            
            Text("Your request has been sent! An invoice will be sent if your friend approves the request")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.greenBrand)
                .multilineTextAlignment(.center)
            
            VStack(spacing:8){
                Button("Check Status", action: {})
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.greenBrand)
                    .clipShape(.rect(cornerRadius: 999))
                    .glassEffect()
                Button("Close", action: {})
                    .font(.headline)
                    .foregroundStyle(.greenBrand)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.mutedSlate.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 999))
                    .glassEffect()
            }
        }
        .padding(40)
    }
}

#Preview {
    RequestSentSheet()
}
