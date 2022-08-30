//
//  FrameRate.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/22/22.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI

/// - SeeAlso: https://developer.apple.com/documentation/quartzcore/optimizing_promotion_refresh_rates_for_iphone_13_pro_and_ipad_pro
public enum FrameRate {
    // MARK: Public Static Interface
    
    public static func set(to preference: Preference) {
        DisplayLinkHolder.shared.setFrameRateRange(to: preference.systemValue)
    }
}

// MARK: - FrameRate.Preference Definition

extension FrameRate {
    public enum Preference {
        case `default`
        case fast
        case slow
        
        // MARK: Public Instance Interface
        
        var systemValue: CAFrameRateRange {
            switch self {
            case .default:
                return .default
            case .fast:
                return CAFrameRateRange(minimum: 80, maximum: 120, preferred: 120)
            case .slow:
                return CAFrameRateRange(minimum: 8, maximum: 15, preferred: 0)
            }
        }
    }
}

// MARK: - DisplayLinkHolder Definition

private final class DisplayLinkHolder {
    fileprivate static let shared = DisplayLinkHolder()
    
    private var displayLink: CADisplayLink!
    
    // MARK: Private Initialization
    
    private init() {
        displayLink = CADisplayLink(target: self, selector: #selector(handler))
        displayLink.add(to: .current, forMode: .default)
    }
    
    // MARK: Fileprivate Instance Interface
    
    fileprivate func setFrameRateRange(to newValue: CAFrameRateRange) {
        displayLink.preferredFrameRateRange = newValue
    }
    
    // MARK: Private Instance Interface
    
    @objc
    private func handler(link: CADisplayLink) {
        // NO-OP
    }
}

#endif
