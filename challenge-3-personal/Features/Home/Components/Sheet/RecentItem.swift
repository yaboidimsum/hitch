import SwiftUI

struct RecentItem: View {
    let place: Place
    let showDivider: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: place.iconName)
                .font(.title3)
                .foregroundStyle(.ink)
                .frame(width: 32, height: 32)

            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(place.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.ink)
                        Text(place.address)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundStyle(.ink)
                    }

                    Spacer()

                    Image(systemName: "ellipsis")
                }

                if showDivider {
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
    VStack(spacing: 16) {
        RecentItem(place: store.recentPlaces[0], showDivider: true)
        RecentItem(place: store.recentPlaces[1], showDivider: false)
    }
    .padding()
}
