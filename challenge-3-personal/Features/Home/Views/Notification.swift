import SwiftUI

struct Notification: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HitchCardList(
                    rides: store.pendingRides,
                    currentUserID: store.currentUser.id
                )
            }
            .padding(.vertical, 16)
        }
        .background(.background)
        .navigationTitle("Notification")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    Notification()
        .environment(AppStore.mock())
}
