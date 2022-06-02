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
                .product(
                    name: "Introspect",
                    package: "SwiftUI-Introspect",
                    condition: .when(platforms: [.iOS, .macOS])
                ),
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
