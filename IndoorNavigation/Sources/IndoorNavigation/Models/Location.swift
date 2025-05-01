import Foundation
import CoreLocation

struct IndoorLocation: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    let floor: Int
    let timestamp: Date
    let accuracy: Double
    let beaconID: String?
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: x, longitude: y)
    }
}

struct Building {
    let id: String
    let name: String
    let floors: [Floor]
    let accessibleRoutes: [Route]
}

struct Floor {
    let number: Int
    let mapImage: String
    let rooms: [Room]
    let landmarks: [Landmark]
}

struct Room {
    let id: String
    let name: String
    let coordinates: (x: Double, y: Double)
    let isAccessible: Bool
}

struct Landmark {
    let id: String
    let name: String
    let type: LandmarkType
    let coordinates: (x: Double, y: Double)
    
    enum LandmarkType {
        case elevator
        case stairs
        case restroom
        case exit
        case other
    }
}

struct Route {
    let id: String
    let start: IndoorLocation
    let end: IndoorLocation
    let isAccessible: Bool
    let distance: Double
    let instructions: [NavigationInstruction]
}

struct NavigationInstruction {
    let id: String
    let type: InstructionType
    let distance: Double
    let description: String
    
    enum InstructionType {
        case turnLeft
        case turnRight
        case continueStraight
        case elevator
        case stairs
        case destination
    }
} 