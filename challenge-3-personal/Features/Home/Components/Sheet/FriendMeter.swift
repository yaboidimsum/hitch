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
                .foregroundStyle(.greenBrand).fontWeight(.semibold)

            HStack(spacing: 16) {
                FriendItem(name: "John Doe", distance: "25m", imageName: "person.fill")
                FriendItem(name: "Jane Doe", distance: "1.2km", imageName: "person.fill")
                FriendItem(name: "Mike", distance: "1.3km", imageName: "person.fill")
                FriendItem(name: "Sarah", distance: "1.3km", imageName: "person.fill")
            }
        }
        .padding(.horizontal,16)
    }
}

#Preview {
    FriendMeter()
}
