import SwiftUI

enum RideStatus: String {
    case pending = "Pending"
    case accepted = "Accepted"
    case inProgress = "In Progress"
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var color: Color {
        switch self {
        case .pending, .accepted, .completed:
            .greenBrand
        case .inProgress:
            .orange
        case .cancelled:
            .red
        }
    }
}
