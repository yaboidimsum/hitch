import SwiftUI

struct LocationCard: View {
    let place: Place
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: place.iconName)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.ink)
                    .font(.callout)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 10)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(place.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.ink)
                    Text(place.address)
                        .font(.caption2)
                        .foregroundStyle(.ink)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
//            .padding(.vertical, 20)
            
//            Rectangle()
//                .fill(.mutedSlate.opacity(0.2))
//                .frame(height: 1)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let store = AppStore.mock()
    LocationCard(place: store.recentPlaces[0])
}
