import SwiftUI
import Contacts

struct RequestPickFriend: View {
    @Environment(AppStore.self) var store
    let selectedPlace: Place
    let onFriendSelected: (User) -> Void
    let onBack: () -> Void
    let currentLocation: String?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .labelStyle(.iconOnly)
                    .font(.title3)
                    .foregroundStyle(.ink)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
                    .glassEffect()
                
                Spacer()
                Text("Pick a friend")
                    .bold()
                    .foregroundStyle(.ink)
                Spacer()
                Circle().frame(width: 44, height: 44).opacity(0)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 20)
            
            VStack(spacing: 20) {
                VStack {
                    DestinationCard(
                        currentLocation: currentLocation,
                        selectedPlace: selectedPlace
                    )
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    Rectangle()
                        .fill(.mutedSlate.opacity(0.2))
                        .frame(height: 1)
                }
            }
            
            Group {
                switch store.contactService.authorizationStatus {
                case .notDetermined:
                    ContentUnavailableView {
                        Label("Contacts Access", systemImage: "person.crop.circle.badge.plus")
                    } description: {
                        Text("Allow access to your contacts to invite friends.")
                    }
                    
                case .denied, .restricted:
                    ContentUnavailableView {
                        Label("Access Denied", systemImage: "lock.fill")
                    } description: {
                        Text("Enable contacts access in Settings to see your friends.")
                    }
                    
                case .authorized:
                    if store.contactService.contacts.isEmpty {
                        ContentUnavailableView {
                            Label("No Contacts", systemImage: "person.2.slash")
                        } description: {
                            Text("Your contacts list is empty.")
                        }
                    } else {
                        List(
                            store.contactService.contacts
                                .filter{
                                    !($0.phoneNumber?.isEmpty ?? true)
                                }
                                .sorted { $0.name < $1.name }) { friend in
                            FriendCard(friend: friend)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    onFriendSelected(friend)
                                }
                        }
                        .listStyle(.plain)
                    }
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    let store = AppStore.mock()
    NavigationStack {
        RequestPickFriend(
            selectedPlace: store.recentPlaces[0],
            onFriendSelected: { _ in },
            onBack: {},
            currentLocation: "Test"
        )
        .environment(store)
    }
}
