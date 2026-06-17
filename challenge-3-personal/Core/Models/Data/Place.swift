import Foundation
import MapKit

struct Place: Identifiable, Hashable {
    let id: UUID
    let name: String
    let address: String
    let iconName: String
    var coordinate: CLLocationCoordinate2D?
    var visitedAt: Date?
    
    init(
        id: UUID = UUID(),
        name: String,
        address: String,
        iconName: String = "mappin",
        coordinate: CLLocationCoordinate2D? = nil,
        visitedAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.address = address
        self.iconName = iconName
        self.coordinate = coordinate
        self.visitedAt = visitedAt
    }
    
    // Hashable conformance
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: Place, rhs: Place) -> Bool {
            lhs.id == rhs.id
        }
}
