import Foundation
import Combine
import CoreLocation

class LocationService {
    private let locationSubject = PassthroughSubject<IndoorLocation, Never>()
    private var timer: Timer?
    private var currentX: Double = 0.0
    private var currentY: Double = 0.0
    private var currentFloor: Int = 1
    
    var locationUpdates: AnyPublisher<IndoorLocation, Never> {
        locationSubject.eraseToAnyPublisher()
    }
    
    func startTracking() {
        // Simulate location updates every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateLocation()
        }
    }
    
    func stopTracking() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateLocation() {
        // Simulate movement in a grid pattern
        currentX += Double.random(in: -1...1)
        currentY += Double.random(in: -1...1)
        
        // Simulate floor changes occasionally
        if Double.random(in: 0...1) < 0.01 {
            currentFloor = Int.random(in: 1...5)
        }
        
        let location = IndoorLocation(
            x: currentX,
            y: currentY,
            floor: currentFloor,
            timestamp: Date(),
            accuracy: Double.random(in: 0.5...2.0),
            beaconID: "beacon_\(Int.random(in: 1...10))"
        )
        
        locationSubject.send(location)
    }
} 