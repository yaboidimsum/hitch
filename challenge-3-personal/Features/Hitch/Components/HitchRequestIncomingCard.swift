import SwiftUI

struct HitchRequestIncomingCard: View {
    let ride: Ride
    let currentUserID: UUID
    
    private var otherPerson: User {
        ride.driver.id == currentUserID ? ride.passenger : ride.driver
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            UserAvatarView(user: otherPerson, size: 64)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(ride.isIncoming(for: currentUserID) ? "+" : "-")Rp\(ride.amount, format: .number)")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.greenBrand)
                
                Text(otherPerson.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.ink.opacity(0.8))
                    .font(.footnote)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 4) {
                        Text("From:").fontWeight(.semibold)
                        Text(ride.origin.name).fontWeight(.medium)
                    }
                    HStack(spacing: 4) {
                        Text("To:").fontWeight(.semibold)
                        Text(ride.destination.name).fontWeight(.medium)
                    }
                }
                .font(.caption2)
            }
            
            HStack(spacing: 4) {
                Button("Reject", systemImage: "xmark", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.greenBrand)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Button("Accept", systemImage: "checkmark", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(.greenBrand)
                    .clipShape(.circle)
                    .glassEffect()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    let store = AppStore.mock()
    HitchRequestIncomingCard(ride: store.pendingRides[0], currentUserID: store.currentUser.id)
}
