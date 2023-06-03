//
//  HasHomeIndicatorEnvironmentValue.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/14/23.
//

import SwiftUI

public struct HasHomeIndicatorKey {
    // NO-OP
}

// MARK: - EnvironmentKey Extension

#if canImport(UIKit)

import UIKit

extension HasHomeIndicatorKey: EnvironmentKey {
    // MARK: Getting the Default Value
    
    public static var defaultValue: Bool {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return false
        }
        
        let bottomSafeAreaInset = windowScene.windows.first?.safeAreaInsets.bottom ?? 0
        
        return bottomSafeAreaInset > 0
    }
}

#else

extension HasHomeIndicatorKey: EnvironmentKey {
    // MARK: Getting the Default Value
    
    public static let defaultValue = false
}

#endif

// MARK: - Extension for EnvironmentValues

extension EnvironmentValues {
    // MARK: Public Instance Interface
    
    public var hasHomeIndicator: Bool {
        get {
            self[HasHomeIndicatorKey.self]
        }
        set {
            self[HasHomeIndicatorKey.self] = newValue
        }
    }
}

