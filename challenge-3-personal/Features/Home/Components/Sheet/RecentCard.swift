import SwiftUI

struct RecentCard: View {
    @Environment(AppStore.self) var store
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("Recents")
                    .font(.headline)
                    .foregroundStyle(.ink)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.greenBrand)
            }
            .fontWeight(.semibold)
            
            VStack {
                ForEach(store.recentPlaces.enumerated(), id: \.element.id) { index, place in
                    RecentItem(
                        place: place,
                        showDivider: index < store.recentPlaces.count - 1
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, index == 0 ? 16 : 8)
                    .padding(.bottom, index == store.recentPlaces.count - 1 ? 16 : 8)
                }
            }
            .background(.background)
            .clipShape(.rect(cornerRadius: 26))
            .shadow(color: .black.opacity(0.07), radius: 8, x: 0, y: 4)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecentCard()
        .environment(AppStore.mock())
}
