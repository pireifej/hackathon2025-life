// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "IndoorNavigation",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "IndoorNavigation",
            targets: ["IndoorNavigation"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "IndoorNavigation",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "IndoorNavigationTests",
            dependencies: ["IndoorNavigation"]),
    ]
) 