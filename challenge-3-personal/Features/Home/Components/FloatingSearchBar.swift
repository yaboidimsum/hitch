//
//  FloatingSearchBar.swift
//  challenge-3-personal
//

import SwiftUI

struct FloatingSearchBar: View {
    @Binding var selectedDetent: PresentationDetent

    var body: some View {
        Searchbar(selectedDetent: $selectedDetent)
            .background(.white)
            .clipShape(.rect(cornerRadius: 999))
    }
}

#Preview {
    FloatingSearchBar(selectedDetent: .constant(.height(70)))
}
