// swift-tools-version:6.2

import PackageDescription

let package = Package(
    name: "code-monkey-apple",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .watchOS(.v26)
    ],
    products: [
        .library(
            name: "CodeMonkeyApple",
            targets: [
                "CodeMonkeyApple"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CodeMonkeyApple",
            dependencies: []
        ),
        .testTarget(
            name: "CodeMonkeyAppleTests",
            dependencies: [
                "CodeMonkeyApple"
            ]
        ),
    ]
)
