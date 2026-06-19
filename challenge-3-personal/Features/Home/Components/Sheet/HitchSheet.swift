//
//  HitchSheet.swift
//  challenge-3-personal
//

import SwiftUI

struct HitchSheet: View {
    @Binding var selectedDetent: PresentationDetent
    var onSearchTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Searchbar(
                selectedDetent: $selectedDetent,
                onSearchTapped: onSearchTapped
            )
            
            ScrollView {
                VStack(spacing: 32) {
                    FriendMeter()
//                    RecentCard()
                }
            }
        }
    }
}

#Preview {
    HitchSheet(
        selectedDetent: .constant(.fraction(0.15)),
        onSearchTapped: {}
    )
}
