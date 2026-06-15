import SwiftUI

struct Activity: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HitchCardList(
                    rides: store.activeRides,
                    currentUserID: store.currentUser.id
                )
            }
            .padding(.vertical, 16)
        }
        .background(.background)
        .navigationTitle("Activity")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    Activity()
        .environment(AppStore.mock())
}
