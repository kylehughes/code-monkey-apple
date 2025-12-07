# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```sh
swift build                    # Build the package
swift test                     # Run all tests
swift test --filter DomainNameTests  # Run a specific test class
```

## Architecture

CodeMonkeyApple is a Swift Package providing utilities for iOS/macOS/watchOS apps. It's a personal utility library with no external dependencies.

### Key Components

**Versionable** (`Sources/CodeMonkeyApple/Versionable/`): Protocol-based system for versioned model migration. Models conform to `Versionable` with an associated `Previous` type, enabling automatic migration chains from older versions.

**Domain Name** (`Sources/CodeMonkeyApple/Domain Name/`): Type-safe handling of domain names (forward and reverse). `DomainNameProtocol` defines the interface; `DomainName` and `ReverseDomainName` are concrete implementations.

**Extensions**: Platform-specific extensions organized by framework (AppKit, UIKit, SwiftUI, Foundation, Core Graphics, Standard Library).

**SwiftUI Components** (`Sources/CodeMonkeyApple/SwiftUI/`): Includes particle emitter wrappers, geometry preference readers, and custom grid layouts.

### Platform Support

- iOS 16+, macOS 12+, watchOS 8+
- Uses conditional compilation (`#if canImport(UIKit)`, `#if canImport(AppKit)`) for platform-specific code

## Test Structure

Tests use Given/When/Then comment style and are organized by feature in `Tests/CodeMonkeyAppleTests/`.

## Localization

Generate strings files with:
```sh
find Sources/CodeMonkeyApple/. -name \*.swift -print0 | xargs -0 genstrings -o Sources/CodeMonkeyApple/Resources/en.lproj
```
