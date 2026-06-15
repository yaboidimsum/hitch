import SwiftUI

struct HitchRequestSheet: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        ScrollView {
            if let activeRide = store.activeRides.first {
                HitchRequestProgressCard(
                    ride: activeRide,
                    currentUserID: store.currentUser.id
                )
            }
        }
    }
}

#Preview {
    HitchRequestSheet()
        .environment(AppStore.mock())
}
