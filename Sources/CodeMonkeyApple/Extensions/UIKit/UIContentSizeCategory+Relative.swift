//
//  UIContentSizeCategory+Relative.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/30/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Extension for UIContentSizeCategory

extension UIContentSizeCategory {
    // MARK: Internal Instance Interface
    
    public var next: UIContentSizeCategory {
        switch self {
        case .extraSmall:
            return .small
        case .small:
            return .medium
        case .medium:
            return .large
        case .large:
            return .extraLarge
        case .extraLarge:
            return .extraExtraLarge
        case .extraExtraLarge:
            return .extraExtraExtraLarge
        case .extraExtraExtraLarge:
            return .accessibilityMedium
        case .accessibilityMedium:
            return .accessibilityLarge
        case .accessibilityLarge:
            return .accessibilityExtraLarge
        case .accessibilityExtraLarge:
            return .accessibilityExtraExtraLarge
        case .accessibilityExtraExtraLarge:
            return .accessibilityExtraExtraExtraLarge
        case .accessibilityExtraExtraExtraLarge:
            return self
        case .unspecified:
            return self
        default:
            return self
        }
    }
    
    public var previous: UIContentSizeCategory {
        switch self {
        case .extraSmall:
            return self
        case .small:
            return .extraSmall
        case .medium:
            return .small
        case .large:
            return .medium
        case .extraLarge:
            return .large
        case .extraExtraLarge:
            return .extraLarge
        case .extraExtraExtraLarge:
            return .extraExtraLarge
        case .accessibilityMedium:
            return .extraExtraExtraLarge
        case .accessibilityLarge:
            return .accessibilityMedium
        case .accessibilityExtraLarge:
            return .accessibilityLarge
        case .accessibilityExtraExtraLarge:
            return .accessibilityExtraLarge
        case .accessibilityExtraExtraExtraLarge:
            return .accessibilityExtraExtraLarge
        case .unspecified:
            return self
        default:
            return self
        }
    }
}

#endif
