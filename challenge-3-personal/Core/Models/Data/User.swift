import Foundation
import MapKit

struct User: Identifiable, Hashable {
    let id: UUID
    let name: String
    let avatarURL: String
    var location: CLLocationCoordinate2D?
    var isAvailable: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        avatarURL: String,
        location: CLLocationCoordinate2D? = nil,
        isAvailable: Bool = false
    ) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.location = location
        self.isAvailable = isAvailable
    }
    
    // Hashable conformance
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: User, rhs: User) -> Bool {
            lhs.id == rhs.id
        }
}
