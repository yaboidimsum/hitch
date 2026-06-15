import SwiftUI

enum SearchDestination: Hashable {
    case pickFriend
    case receipt
}

struct SearchFlow: View {
    @Environment(AppStore.self) var store
    @Binding var sheetContent: SheetContent
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            RequestSearchLocation(
                onDismiss: { withAnimation{
                    sheetContent = .hitch} }
            )
            .navigationBarHidden(true)
            .navigationDestination(for: SearchDestination.self) { destination in
                switch destination {
                case .pickFriend:
                    RequestPickFriend(
                        onBack: { path.removeLast() },
                        onConfirm: { path.append(SearchDestination.receipt) }
                    )
                    .navigationBarHidden(true)
                case .receipt:
                    RequestReceipt(
                        onBack: { path.removeLast() },
                        onDone: {
                            path.removeLast(path.count)
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
