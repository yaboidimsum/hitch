import SwiftUI

struct HitchCardList: View {
    let rides: [Ride]
    let currentUserID: UUID
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(rides.enumerated(), id: \.element.id) { index, ride in
                HitchCard(
                    ride: ride,
                    currentUserID: currentUserID
                )
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                
                if index < rides.count - 1 {
                    Rectangle()
                        .fill(.secondary.opacity(0.3))
                        .frame(height: 1)
                }
            }
        }
    }
}

#Preview {
    let store = AppStore.mock()
    HitchCardList(
        rides: store.history,
        currentUserID: store.currentUser.id
    )
}
