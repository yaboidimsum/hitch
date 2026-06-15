//
//  HitchSheet.swift
//  challenge-3-personal
//

import SwiftUI

struct HitchSheet: View {
    @Binding var selectedDetent: PresentationDetent
    
    var body: some View {
        VStack(spacing: 0) {
            Searchbar(selectedDetent: $selectedDetent)
            
            ScrollView {
                VStack(spacing: 32) {
                    FriendMeter()
                    RecentCard()
                }
            }
        }
    }
}

#Preview {
    HitchSheet(selectedDetent: .constant(.fraction(0.15)))
}
