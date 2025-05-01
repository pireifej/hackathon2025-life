# Indoor Navigation App

A SwiftUI-based iPhone app that provides real-time indoor navigation with AR capabilities.

## Features

- Real-time indoor positioning using simulated Bluetooth beacons
- Floor plan integration with OpenStreetMap
- Accessibility options for step-free navigation
- Voice-guided turn-by-turn navigation
- ARKit-powered augmented reality navigation
- Emergency support with exit path visualization

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Project Structure

```
IndoorNavigation/
├── App/
│   ├── IndoorNavigationApp.swift
│   └── AppDelegate.swift
├── Models/
│   ├── Location.swift
│   ├── Route.swift
│   └── Building.swift
├── Views/
│   ├── MapView.swift
│   ├── ARNavigationView.swift
│   ├── SettingsView.swift
│   └── EmergencyView.swift
├── ViewModels/
│   ├── NavigationViewModel.swift
│   └── LocationViewModel.swift
├── Services/
│   ├── LocationService.swift
│   ├── VoiceNavigationService.swift
│   └── ARService.swift
└── Resources/
    ├── Assets.xcassets
    └── SampleFloorPlan.svg
```

## Setup

1. Clone the repository
2. Open `IndoorNavigation.xcodeproj` in Xcode
3. Build and run on an iOS device or simulator

## License

MIT License 