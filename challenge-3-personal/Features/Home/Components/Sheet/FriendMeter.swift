//
//  FriendMeter.swift
//  challenge-3-personal
//

import SwiftUI

struct FriendMeter: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nearby Friends")
                .font(.headline)
                .foregroundStyle(.ink).fontWeight(.semibold)

            HStack(spacing: 16) {
                FriendItem(name: "John Doe", distance: "25m", imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=John")
                FriendItem(name: "Jane Doe", distance: "1.2km", imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Jane")
                FriendItem(name: "Mike", distance: "1.3km", imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Mike")
                FriendItem(name: "Sarah", distance: "1.3km", imageUrl: "https://api.dicebear.com/10.x/lorelei/png?seed=Sarah")
            }
        }
        .padding(.horizontal,16)
    }
}

#Preview {
    FriendMeter()
}
