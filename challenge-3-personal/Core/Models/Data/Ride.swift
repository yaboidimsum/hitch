import Foundation

struct Ride: Identifiable {
    let id: UUID
    let passenger: User
    let driver: User
    let origin: Place
    let destination: Place
    let amount: Int
    var status: RideStatus
    let createdAt: Date
    var completedAt: Date?
    
    init(
        id: UUID = UUID(),
        passenger: User,
        driver: User,
        origin: Place,
        destination: Place,
        amount: Int,
        status: RideStatus,
        createdAt: Date = Date(),
        completedAt: Date? = nil
    ) {
        self.id = id
        self.passenger = passenger
        self.driver = driver
        self.origin = origin
        self.destination = destination
        self.amount = amount
        self.status = status
        self.createdAt = createdAt
        self.completedAt = completedAt
    }
    
    var rideStatus: RideStatus {
        get { status }
        set { status = newValue }
    }
    
    func role(for userID: UUID) -> RideRole {
        driver.id == userID ? .driver : .passenger
    }
    
    func isIncoming(for userID: UUID) -> Bool {
        role(for: userID) == .driver
    }
}
