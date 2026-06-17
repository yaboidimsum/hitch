import MapKit

@MainActor
@Observable
final class LocationService {
    var userLocation: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    private let manager = CLLocationManager()
    private let locationDelegate: LocationDelegate
    private var trackingCount = 0

    init() {
        locationDelegate = LocationDelegate()
        locationDelegate.onLocationUpdate = { [weak self] coordinate in
            Task { @MainActor in
                self?.userLocation = coordinate
            }
        }
        locationDelegate.onAuthorizationChange = { [weak self] status in
            Task { @MainActor in
                self?.authorizationStatus = status
                #if os(iOS)
                if status == .authorizedWhenInUse || status == .authorizedAlways {
                    self?.manager.startUpdatingLocation()
                }
                #else
                if status == .authorizedAlways {
                    self?.manager.startUpdatingLocation()
                }
                #endif
            }
        }
        manager.delegate = locationDelegate
        requestAuthorization()
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        trackingCount += 1
        if trackingCount == 1 {
            manager.startUpdatingLocation()
        }
    }

    func stopTracking() {
        guard trackingCount > 0 else { return }
        trackingCount -= 1
        if trackingCount == 0 {
            manager.stopUpdatingLocation()
        }
    }
}

final class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onAuthorizationChange?(status)
    }
}
