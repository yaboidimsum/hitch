import SwiftUI

struct HitchCard: View {
    let ride: Ride
    let currentUserID: UUID
    
    private var otherPerson: User {
        ride.driver.id == currentUserID ? ride.passenger : ride.driver
    }
    
    private var role: RideRole {
        ride.role(for: currentUserID)
    }
    
    private var isIncoming: Bool {
        ride.isIncoming(for: currentUserID)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            HStack(alignment: .center) {
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
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("\(otherPerson.name) (\(role.rawValue))")
                            .fontWeight(.medium)
                            .foregroundStyle(.ink.opacity(0.8))
                        Text(ride.destination.name)
                            .fontWeight(.semibold)
                            .foregroundStyle(.ink)
                    }
                    .font(.footnote)
                    
                    Text(ride.rideStatus.rawValue)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(ride.rideStatus.color)
                        .clipShape(.rect(cornerRadius: 999))
                        .fontWeight(.semibold)
                        .font(.caption2)
                        .glassEffect()
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(isIncoming ? "+" : "-")Rp\(ride.amount, format: .number)")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(isIncoming ? .greenBrand : .ink.opacity(0.8))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    let store = AppStore.mock()
    VStack(spacing: 12) {
        HitchCard(
            ride: store.history[0],
            currentUserID: store.currentUser.id
        )
        
        HitchCard(
            ride: store.history[1],
            currentUserID: store.currentUser.id
        )
        
        HitchCard(
            ride: store.history[2],
            currentUserID: store.currentUser.id
        )
    }
    .padding()
}
