//
//  MapButton.swift
//  challenge-3-personal
//
//  Created by Dimas Prihady Setyawan on 14/06/26.
//

import SwiftUI

struct MapButton: View{
    var body: some View{
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: "map.fill").font(.footnote)
                Text("Choose on map").font(.footnote)
            }
        }
        .foregroundStyle(.greenBrand)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .clipShape(.rect(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 999)
                .stroke(.mutedSlate.opacity(0.5), lineWidth: 1)
        }
    }
}

#Preview {
    MapButton()
}
