//
//  RecentItem.swift
//  challenge-3-personal
//

import SwiftUI

struct RecentItem: View {
    let name: String
    let address: String
    let showDivider: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32)
                .clipShape(.circle)

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
    RecentItem(name: "Little Olie!", address: "Bendungan Hilir, South Jakarta", showDivider: true)
}
