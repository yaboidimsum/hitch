import Foundation
import MapKit
import Contacts

struct User: Identifiable, Hashable {
    let id: UUID
    let name: String
    let avatarURL: String?
    let avatarData: Data?
    let phoneNumber: String?
    var location: CLLocationCoordinate2D?
    var isAvailable: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        avatarURL: String? = nil,
        avatarData: Data? = nil,
        location: CLLocationCoordinate2D? = nil,
        phoneNumber: String?,
        isAvailable: Bool = false
    ) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.avatarData = avatarData
        self.location = location
        self.phoneNumber = phoneNumber
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

extension User{
    init(from contact: CNContact) {
           let fullName = [contact.givenName, contact.familyName]
               .filter { !$0.isEmpty }
               .joined(separator: " ")
        
        let phone = contact.phoneNumbers.first?.value.stringValue
        let avatarData = contact.thumbnailImageData
           
           self.init(
               name: fullName.isEmpty ? "Unknown" : fullName,
               avatarData: avatarData,
               phoneNumber: phone,
               isAvailable: false   // Contacts don't have real-time availability
                
           )
       }
}
