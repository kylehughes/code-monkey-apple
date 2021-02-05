// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "code-monkey-apple",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "CodeMonkeyApple",
            targets: ["CodeMonkeyApple"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CodeMonkeyApple",
            dependencies: []
        ),
        .testTarget(
            name: "CodeMonkeyAppleTests",
            dependencies: ["CodeMonkeyApple"]
        ),
    ]
)
