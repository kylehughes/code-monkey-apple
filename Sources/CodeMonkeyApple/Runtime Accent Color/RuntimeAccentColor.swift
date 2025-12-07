//
//  RuntimeAccentColor.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/10/22.
//

import SwiftUI

public enum RuntimeAccentColor: String, CaseIterable, SynthesizedIdentifiable, Sendable {
    case blue
    case brown
    case coral
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
        case .coral:
            return Color(.displayP3, red: 255/255, green: 130/255, blue: 119/255, opacity: 1.0)
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
            return .blueColor
        case .brown:
            return .brownColor
        case .coral:
            return .coralColor
        case .cyan:
            return .cyanColor
        case .default:
            return .default
        case .green:
            return .greenColor
        case .indigo:
            return .indigoColor
        case .mint:
            return .mintColor
        case .orange:
            return .orangeColor
        case .pink:
            return .pinkColor
        case .primary:
            return .blackWhiteColor
        case .purple:
            return .purpleColor
        case .red:
            return .redColor
        case .teal:
            return .tealColor
        case .yellow:
            return .yellowColor
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
