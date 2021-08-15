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
        .library(
            name: "CodeMonkeyAppleIntrospect",
            targets: [
                "CodeMonkeyAppleIntrospect"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "CodeMonkeyApple",
            dependencies: []
        ),
        .target(
            name: "CodeMonkeyAppleIntrospect",
            dependencies: [
                "CodeMonkeyApple",
                .product(name: "Introspect", package: "SwiftUI-Introspect"),
            ]
        ),
        .testTarget(
            name: "CodeMonkeyAppleTests",
            dependencies: [
                "CodeMonkeyApple"
            ]
        ),
    ]
)
