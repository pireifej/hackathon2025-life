import Foundation
import CoreLocation
import Combine

class LocationViewModel: ObservableObject {
    @Published var currentLocation: IndoorLocation?
    @Published var currentFloor: Int = 1
    @Published var isTracking = false
    @Published var accuracy: Double = 0.0
    
    private var locationService: LocationService
    private var cancellables = Set<AnyCancellable>()
    
    init(locationService: LocationService = LocationService()) {
        self.locationService = locationService
        setupLocationUpdates()
    }
    
    private func setupLocationUpdates() {
        locationService.locationUpdates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                self?.currentLocation = location
                self?.currentFloor = location.floor
                self?.accuracy = location.accuracy
            }
            .store(in: &cancellables)
    }
    
    func startTracking() {
        isTracking = true
        locationService.startTracking()
    }
    
    func stopTracking() {
        isTracking = false
        locationService.stopTracking()
    }
    
    func calculateRoute(to destination: IndoorLocation) -> Route? {
        // This would be implemented with actual route calculation logic
        // For now, return a mock route
        guard let start = currentLocation else { return nil }
        
        return Route(
            id: UUID().uuidString,
            start: start,
            end: destination,
            isAccessible: true,
            distance: 100.0,
            instructions: [
                NavigationInstruction(
                    id: "1",
                    type: .continueStraight,
                    distance: 50.0,
                    description: "Continue straight for 50 feet"
                ),
                NavigationInstruction(
                    id: "2",
                    type: .turnRight,
                    distance: 30.0,
                    description: "Turn right in 30 feet"
                ),
                NavigationInstruction(
                    id: "3",
                    type: .destination,
                    distance: 20.0,
                    description: "Destination ahead"
                )
            ]
        )
    }
} 