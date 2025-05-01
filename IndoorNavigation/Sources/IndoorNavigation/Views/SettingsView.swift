import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @AppStorage("isStepFreeNavigation") private var isStepFreeNavigation = false
    @AppStorage("avoidEscalators") private var avoidEscalators = false
    @AppStorage("avoidCrowdedZones") private var avoidCrowdedZones = false
    @AppStorage("voiceGuidanceEnabled") private var voiceGuidanceEnabled = true
    @AppStorage("voiceVolume") private var voiceVolume: Double = 0.8
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accessibility Options")) {
                    Toggle("Step-Free Navigation", isOn: $isStepFreeNavigation)
                    Toggle("Avoid Escalators", isOn: $avoidEscalators)
                    Toggle("Avoid Crowded Zones", isOn: $avoidCrowdedZones)
                }
                
                Section(header: Text("Voice Guidance")) {
                    Toggle("Enable Voice Guidance", isOn: $voiceGuidanceEnabled)
                    
                    if voiceGuidanceEnabled {
                        HStack {
                            Text("Volume")
                            Slider(value: $voiceVolume, in: 0...1)
                        }
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                    Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
                }
            }
            .navigationTitle("Settings")
        }
    }
} 