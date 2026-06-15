import SwiftUI

enum HitchRequestState {
    case empty
    case incoming(Ride)
    case inProgress(Ride)
    case done(Ride)
    case rejected(Ride)
}
