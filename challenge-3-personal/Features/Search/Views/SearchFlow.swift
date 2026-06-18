import SwiftUI
internal import _LocationEssentials

struct SearchFlow: View {
    @State private var model = SearchFlowModel()
    @State private var mapModel = MapModel()
    @Environment(AppStore.self) private var store
    @Binding var sheetContent: SheetContent
    @Binding var routeDistance: Double?
    let onDestinationSelected: ((Place) -> Void)?
    let onReset: (() -> Void)?
    
    private var userLocationKey: String {
        guard let loc = store.locationService.userLocation else { return "nil" }
        return "\(loc.latitude),\(loc.longitude)"
    }
    
    var body: some View {
        NavigationStack(path: $model.path) {
            RequestSearchLocation(
                onDismiss: {
                    withAnimation {
                        sheetContent = .hitch
                    }
                },
                onPlaceSelected: { place in
                    onDestinationSelected?(place)
                    model.selectPlace(place)
                },
                currentLocation: mapModel.currentLocationAddress
            )
            .navigationBarHidden(true)
            .navigationDestination(for: SearchStep.self) { step in
                switch step {
                case .location:
                    EmptyView()
                case .pickFriend(let place):
                    RequestPickFriend(
                        selectedPlace: place,
                        onFriendSelected: { friend in
                            model.selectFriend(friend)
                        }, onBack: {model.path.removeLast()}, currentLocation: mapModel.currentLocationAddress
                    )
                    .navigationBarHidden(true)
                case .receipt(let place, let friend):
                    RequestReceipt(
                        selectedPlace: place,
                        selectedFriend: friend,
                        onBack: {
                            model.path.removeLast()
                        },
                        onSend: {
                            model.sendRequest()
                        },
                        currentLocation: mapModel.currentLocationAddress,
                        distance: routeDistance
                    ).navigationBarHidden(true)
                case .sent(let place, let friend):
                    RequestSentSheet(
                        selectedPlace: place, selectedfriend: friend, onConfirm: {
                            model.reset()
                            onReset?()
                            withAnimation{
                                sheetContent = .hitch
                            }
                        }
                        
                    )
                    .navigationBarHidden(true)
                }
            }
        }
        .onAppear {
            store.locationService.startTracking()
        }
        .onDisappear {
            store.locationService.stopTracking()
        }
        .onChange(of: userLocationKey) { _, _ in
            mapModel.reverseGeocode(store.locationService.userLocation)
        }
    }
}

#Preview {
    SearchFlow(
        sheetContent: .constant(.search),
        routeDistance: .constant(3500),
        onDestinationSelected: nil,
        onReset: nil
    )
    .environment(AppStore.mock())
}
