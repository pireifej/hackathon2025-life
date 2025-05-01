import SwiftUI

@main
struct IndoorNavigationApp: App {
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var navigationViewModel = NavigationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationViewModel)
                .environmentObject(navigationViewModel)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(0)
            
            ARNavigationView()
                .tabItem {
                    Label("AR", systemImage: "camera.viewfinder")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
    }
} 