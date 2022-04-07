//
//  RuntimeColorScheme.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/4/21.
//

import SwiftUI

public enum RuntimeColorScheme: String, Codable, SynthesizedIdentifiable {
    case dark = "dark"
    case light = "light"
    case system = "system"
    
    // MARK: Public Static Interface
    
    public static let allCasesInDisplayOrder: [RuntimeColorScheme] = [
        .system,
        .light,
        .dark,
    ]
    
    // MARK: Public Instance Interface
    
    public var platformValue: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
    
    public var title: String {
        switch self {
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        case .system:
            return "System"
        }
    }
}

// MARK: - Storable Extension

extension RuntimeColorScheme: Storable {
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> String?) -> RuntimeColorScheme? {
        guard let rawValue = storage() else {
            return nil
        }
        
        return RuntimeColorScheme(rawValue: rawValue)
    }
    
    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> String {
        rawValue
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func preferredColorScheme(_ runtimeColorScheme: RuntimeColorScheme) -> some View {
        preferredColorScheme(runtimeColorScheme.platformValue)
    }
}
