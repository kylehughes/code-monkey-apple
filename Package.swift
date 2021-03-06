// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "code-monkey-apple",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CodeMonkeyApple",
            targets: [
                "CodeMonkeyApple"
            ]
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
            dependencies: [
                "CodeMonkeyApple"
            ]
        ),
    ]
)
