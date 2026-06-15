import SwiftUI

struct HitchRequestProgressCard: View {
    let ride: Ride
    let currentUserID: UUID
    
    private var otherPerson: User {
        ride.driver.id == currentUserID ? ride.passenger : ride.driver
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Go pick em!").fontWeight(.semibold)
            
            HStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: otherPerson.avatarURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .fill(.gray.opacity(0.3))
                }
                .frame(width: 64, height: 64)
                .clipShape(.circle)
                
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
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .clipShape(.rect(cornerRadius: 16))
            
            Button("Cancel Request", action: {})
                .font(.headline)
                .foregroundStyle(.greenBrand)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(.mutedSlate.opacity(0.2))
                .clipShape(.rect(cornerRadius: 999))
                .glassEffect()
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 40)
    }
}

#Preview {
    let store = AppStore.mock()
    HitchRequestProgressCard(ride: store.activeRides[0], currentUserID: store.currentUser.id)
}
