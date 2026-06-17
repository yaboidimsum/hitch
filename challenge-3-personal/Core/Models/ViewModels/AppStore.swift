import Foundation
import SwiftUI

@MainActor
@Observable
final class AppStore {
    var currentUser: User
    var friends: [User]
    var recentPlaces: [Place]
    var rides: [Ride]
    var weather: WeatherData
    var locationService: LocationService
    
    init(
        currentUser: User,
        friends: [User] = [],
        recentPlaces: [Place] = [],
        rides: [Ride] = [],
        weather: WeatherData = WeatherData(
            iconName: "sun.max.fill",
            temperature: 27,
            tempUnit: "°C"
        ),
        locationService: LocationService? = nil
    ) {
        self.currentUser = currentUser
        self.friends = friends
        self.recentPlaces = recentPlaces
        self.rides = rides
        self.weather = weather
        self.locationService = locationService ?? LocationService()
    }
    
    var activeRides: [Ride] {
        rides.filter { $0.rideStatus == .inProgress || $0.rideStatus == .accepted }
    }
    
    var pendingRides: [Ride] {
        rides.filter { $0.rideStatus == .pending }
    }
    
    var history: [Ride] {
        rides.filter { $0.rideStatus == .completed || $0.rideStatus == .cancelled }
    }
}

// MARK: - Mock Data

extension AppStore {
    @MainActor
    static func mock() -> AppStore {
        let currentUser = User(
            name: "Dimas",
            avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Dimas"
        )
        
        let friends = [
            User(name: "Kanye West", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Kanye", isAvailable: true),
            User(name: "John Doe", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=John", isAvailable: true),
            User(name: "Jane Smith", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Jane", isAvailable: true),
            User(name: "Mike Smith", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Mike", isAvailable: true),
            User(name: "Sarah Lee", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Sarah", isAvailable: true),
            User(name: "Tom Brown", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Tom", isAvailable: true),
            User(name: "Emily Davis", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Emily", isAvailable: true),
            User(name: "Nadya", avatarURL: "https://api.dicebear.com/10.x/lorelei/png?seed=Nadya", isAvailable: true)
        ]
        
        let places = [
            Place(name: "Apple Developer Academy @ Binus Tangerang", address: "Jl. Grand Boulevard, BSD Green Office Park 9, BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345", iconName: "building.2.fill"),
            Place(name: "Monumen Nasional", address: "Merdeka Square, Jakarta, Jalan Lapangan Monas, RT.5/RW.2, Gambir, Central Jakarta City, Jakarta 10110", iconName: "building.1.fill"),
            Place(name: "Gelora Bung Karno", address: "Jl. Pintu Satu Senayan, RT.1/RW.3, Gelora, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10270", iconName: "sportscourt.fill"),
            Place(name: "McDonald's Salemba Raya", address: "Salemba, Jakarta Pusat", iconName: "bag.fill"),
            Place(name: "Central Park Mall", address: "Grogol, Jakarta Barat", iconName: "bag.fill"),
            Place(name: "Apple Developer Academy", address: "BSD Green Office Park, Tangerang", iconName: "apple.logo")
        ]
        
        let rides = [
            // History: Kanye as passenger, Dimas as driver, completed
            Ride(
                passenger: friends[0],
                driver: currentUser,
                origin: places[0],
                destination: places[3],
                amount: 20000,
                status: .completed
            ),
            // History: John as driver, Dimas as passenger, completed
            Ride(
                passenger: currentUser,
                driver: friends[1],
                origin: places[0],
                destination: places[4],
                amount: 20000,
                status: .completed
            ),
            // History: Jane as passenger, Dimas as driver, cancelled
            Ride(
                passenger: friends[2],
                driver: currentUser,
                origin: places[0],
                destination: places[1],
                amount: 20000,
                status: .cancelled
            ),
            // Activity: Kanye as passenger, Dimas as driver, in progress
            Ride(
                passenger: friends[0],
                driver: currentUser,
                origin: places[0],
                destination: places[3],
                amount: 20000,
                status: .inProgress
            ),
            // Activity: Kanye as driver, Dimas as passenger, in progress
            Ride(
                passenger: currentUser,
                driver: friends[0],
                origin: places[0],
                destination: places[3],
                amount: 20000,
                status: .inProgress
            ),
            // Notification: Kanye as passenger, Dimas as driver, pending
            Ride(
                passenger: friends[0],
                driver: currentUser,
                origin: places[0],
                destination: places[3],
                amount: 20000,
                status: .pending
            )
        ]
        
        return AppStore(
            currentUser: currentUser,
            friends: friends,
            recentPlaces: places.prefix(3).map { $0 },
            rides: rides,
            weather: WeatherData(iconName: "sun.max.fill", temperature: 27),
            locationService: LocationService()
        )
    }
}
