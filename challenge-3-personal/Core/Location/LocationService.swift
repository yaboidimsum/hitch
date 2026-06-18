import MapKit

@MainActor
@Observable
final class LocationService {
    var userLocation: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    private var manager: CLLocationManager?
    private var locationDelegate: LocationDelegate?
    private var trackingCount = 0

    func setupIfNeeded() {
        guard manager == nil else { return }
        let delegate = LocationDelegate()
        delegate.onLocationUpdate = { [weak self] coordinate in
            Task { @MainActor in
                self?.userLocation = coordinate
            }
        }
        delegate.onAuthorizationChange = { [weak self] status in
            Task { @MainActor in
                self?.authorizationStatus = status
                #if os(iOS)
                if status == .authorizedWhenInUse || status == .authorizedAlways {
                    self?.manager?.startUpdatingLocation()
                }
                #else
                if status == .authorizedAlways {
                    self?.manager?.startUpdatingLocation()
                }
                #endif
            }
        }
        let m = CLLocationManager()
        m.desiredAccuracy = kCLLocationAccuracyHundredMeters
        m.distanceFilter = 25
        m.delegate = delegate
        authorizationStatus = m.authorizationStatus
        self.manager = m
        self.locationDelegate = delegate
    }

    func requestAuthorization() {
        setupIfNeeded()
        guard manager?.authorizationStatus == .notDetermined else { return }
        manager?.requestWhenInUseAuthorization()
    }

    func startTracking() {
        setupIfNeeded()
        trackingCount += 1
        if trackingCount == 1 {
            guard let manager else { return }
            authorizationStatus = manager.authorizationStatus

            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            default:
                break
            }
        }
    }

    func stopTracking() {
        guard trackingCount > 0 else { return }
        trackingCount -= 1
        if trackingCount == 0 {
            manager?.stopUpdatingLocation()
        }
    }
}

final class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?

    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        onLocationUpdate?(location.coordinate)
    }

    @objc func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onAuthorizationChange?(status)
    }

    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location failure silently
    }
}
