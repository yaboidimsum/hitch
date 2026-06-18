import Foundation
import MapKit

@MainActor
@Observable
class SearchFlowModel {
    var path: [SearchStep] = []
    var selectedPlace: Place?
    var selectedFriend: User?

    
    func selectPlace(_ place: Place) {
        selectedPlace = place
        path.append(.pickFriend(selectedPlace: place))
    }
    
    func selectFriend(_ friend: User) {
        selectedFriend = friend
        guard let place = selectedPlace else { return }
        path.append(.receipt(selectedPlace: place, selectedFriend: friend))
    }
    
    func sendRequest() {
        guard let place = selectedPlace, let friend = selectedFriend else { return }
        path.append(.sent(selectedPlace: place, selectedFriend: friend))
    }
    
    func goBack() {
        guard path.count > 1 else { return }
        path.removeLast()
    }
    
    func reset() {
        path.removeAll()
        selectedPlace = nil
        selectedFriend = nil
    }
}
