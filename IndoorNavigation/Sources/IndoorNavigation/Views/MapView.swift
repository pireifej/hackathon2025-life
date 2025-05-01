import SwiftUI
import CoreLocation

struct MapView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @State private var selectedDestination: Room?
    @State private var showEmergencyView = false
    
    var body: some View {
        ZStack {
            // Floor plan background
            Image("SampleFloorPlan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    // Current location indicator
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .position(
                            x: locationViewModel.currentLocation?.x ?? 0,
                            y: locationViewModel.currentLocation?.y ?? 0
                        )
                )
            
            // Navigation controls
            VStack {
                Spacer()
                HStack {
                    // Floor selector
                    Picker("Floor", selection: $locationViewModel.currentFloor) {
                        ForEach(1...5, id: \.self) { floor in
                            Text("Floor \(floor)").tag(floor)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Emergency button
                    Button(action: { showEmergencyView = true }) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .padding()
                            .background(Circle().fill(Color.white))
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showEmergencyView) {
            EmergencyView()
        }
        .onAppear {
            locationViewModel.startTracking()
        }
        .onDisappear {
            locationViewModel.stopTracking()
        }
    }
}

struct EmergencyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                
                Text("Emergency Exit Routes")
                    .font(.title)
                    .bold()
                
                // Emergency exit routes would be displayed here
                List {
                    Section(header: Text("Nearest Exits")) {
                        Text("Main Entrance - 50 feet")
                        Text("Fire Exit - 30 feet")
                        Text("Emergency Stairs - 20 feet")
                    }
                }
                
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
} 