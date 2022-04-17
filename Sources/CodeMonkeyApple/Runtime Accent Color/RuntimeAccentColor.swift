//
//  RuntimeAccentColor.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/10/22.
//

import SwiftUI

public enum RuntimeAccentColor: String, CaseIterable, Storable, SynthesizedIdentifiable {
    case blue
    case brown
    case cyan
    case `default`
    case green
    case indigo
    case mint
    case orange
    case pink
    case primary
    case purple
    case red
    case teal
    case yellow
    
    // MARK: Public Static Interface
    
    public static let allCasesInDisplayOrder: [RuntimeAccentColor] = allCases.sorted { $0.title < $1.title }
    
    public static let defaultEquivalent: RuntimeAccentColor = {
        #if canImport(UIKit)
        for color in allCases {
            guard
                color != .default,
                color.platformValue.rgbaEqualsRGBA(from: RuntimeAccentColor.default.platformValue)
            else {
                continue
            }
            
            return color
        }
        #endif
        
        return .default
    }()
    
    // MARK: Public Instance Interface
    
    public var nonDefaultEquivalent: RuntimeAccentColor {
        guard self == .default else {
            return self
        }
        
        return .defaultEquivalent
    }
    
    public var platformValue: Color {
        switch self {
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .cyan:
            return .cyan
        case .default:
            return Color("AccentColor")
        case .green:
            return .green
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .primary:
            return .primary
        case .purple:
            return .purple
        case .red:
            return .red
        case .teal:
            return .teal
        case .yellow:
            return .yellow
        }
    }
    
    public var title: String {
        switch self {
        case .blue:
            return "Blue"
        case .brown:
            return "Brown"
        case .cyan:
            return "Cyan"
        case .default:
            return "Default"
        case .green:
            return "Green"
        case .indigo:
            return "Indigo"
        case .mint:
            return "Mint"
        case .orange:
            return "Orange"
        case .pink:
            return "Pink"
        case .primary:
            return "Black / White"
        case .purple:
            return "Purple"
        case .red:
            return "Red"
        case .teal:
            return "Teal"
        case .yellow:
            return "Yellow"
        }
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func accentColor(_ runtimeAccentColor: RuntimeAccentColor) -> some View {
        accentColor(runtimeAccentColor.platformValue)
    }
}
