import SwiftUI

struct History: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HitchCardList(
                    rides: store.history,
                    currentUserID: store.currentUser.id
                )
            }
            .padding(.vertical, 16)
        }
        .background(.background)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    History()
        .environment(AppStore.mock())
}
