import MapKit

@MainActor
@Observable
final class DestinationSearchModel {
    var query: String = ""
    var results: [Place] = []
    var isSearching = false
    
    private var currentTask: Task<Void, Never>?
    
    func search(near coordinate: CLLocationCoordinate2D?) {
        currentTask?.cancel()
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            results = []
            return
        }
        
        currentTask = Task { @MainActor in
            isSearching = true
            defer { if !Task.isCancelled { isSearching = false } }
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = trimmed
            
            let searchCenter = coordinate ?? CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
            request.region = MKCoordinateRegion(
                center: searchCenter,
                latitudinalMeters: 50_000,
                longitudinalMeters: 50_000
            )
            
            do {
                let response = try await MKLocalSearch(request: request).start()
                guard !Task.isCancelled else { return }
                results = response.mapItems.map { Place(from: $0) }
            } catch {
                guard !Task.isCancelled else { return }
                results = []
            }
        }
    }
    
    func clear() {
        query = ""
        results = []
        currentTask?.cancel()
    }
}
