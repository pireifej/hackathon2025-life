import Foundation
import Combine

class NavigationViewModel: ObservableObject {
    @Published var currentRoute: Route?
    @Published var currentInstruction: NavigationInstruction?
    @Published var isNavigating = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func startNavigation(to destination: IndoorLocation) {
        // This would calculate the actual route based on preferences
        // For now, use a mock route
        currentRoute = Route(
            id: UUID().uuidString,
            start: IndoorLocation(x: 0, y: 0, floor: 1, timestamp: Date(), accuracy: 1.0, beaconID: nil),
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
        
        isNavigating = true
        updateCurrentInstruction()
    }
    
    func stopNavigation() {
        currentRoute = nil
        currentInstruction = nil
        isNavigating = false
    }
    
    private func updateCurrentInstruction() {
        guard let route = currentRoute else { return }
        
        // Find the next instruction based on current location
        // For now, just use the first instruction
        currentInstruction = route.instructions.first
    }
    
    func updateLocation(_ location: IndoorLocation) {
        guard isNavigating, let route = currentRoute else { return }
        
        // Update current instruction based on location
        // This would calculate which instruction is most relevant
        // For now, just use the first instruction
        currentInstruction = route.instructions.first
    }
} 