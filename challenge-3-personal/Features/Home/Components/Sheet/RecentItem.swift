//
//  RecentItem.swift
//  challenge-3-personal
//

import SwiftUI

struct RecentItem: View {
    let name: String
    let address: String
    let showDivider: Bool
    let iconName: String

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(.greenBrand)
                .frame(width: 32, height: 32)

            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        Text(address)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "ellipsis")
                }

                if showDivider {
                    Rectangle()
                        .fill(.secondary.opacity(0.3))
                        .frame(height: 1)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        RecentItem(name: "Autograph Tower", address: "Casablanca, Jakarta Selatan", showDivider: true, iconName: "building.2.fill")
        RecentItem(name: "Apple Developer Academy", address: "BSD Green Office Park, Tangerang", showDivider: false, iconName: "apple.logo")
    }
    .padding()
}
