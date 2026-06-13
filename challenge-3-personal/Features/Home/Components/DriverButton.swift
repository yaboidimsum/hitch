//
//  DriverButton.swift
//  challenge-3-personal
//

import SwiftUI

struct DriverButton: View {
    var body: some View {
        Button("Driver", systemImage: "moped", action: {})
            .labelStyle(.iconOnly).font(.title3)
            .foregroundStyle(.greenBrand)
            .frame(width: 44, height: 44)
            .clipShape(.circle)
            .glassEffect()
    }
}

#Preview {
    DriverButton()
}
