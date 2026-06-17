import SwiftUI

struct SearchFlow: View {
    @Bindable private var model = SearchFlowModel()
    @Environment(AppStore.self) private var store
    @Binding var sheetContent: SheetContent
    
    var body: some View {
        NavigationStack(path: $model.path) {
            RequestSearchLocation(
                onDismiss: {
                    withAnimation {
                        sheetContent = .hitch
                    }
                },
                onPlaceSelected: { place in
                    model.selectPlace(place)
                }
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
                        }, onBack: {model.path.removeLast()}
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
                        }
                    ).navigationBarHidden(true)
                case .sent(let place, let friend):
                    RequestSentSheet(
                        selectedPlace: place, selectedfriend: friend, onConfirm: {
                            model.reset()
                            withAnimation{
                                sheetContent = .hitch
                            }
                        }
                        
                    )
                    .navigationBarHidden(true)
                }
            }
        }
    }
}

#Preview {
    SearchFlow(sheetContent: .constant(.search))
        .environment(AppStore.mock())
}
