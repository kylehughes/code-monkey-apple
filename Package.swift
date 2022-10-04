// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "code-monkey-apple",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8)
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
