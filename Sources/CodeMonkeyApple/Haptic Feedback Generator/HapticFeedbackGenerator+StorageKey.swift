//
//  HapticFeedbackGenerator+StorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/3/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Extension for HapticFeedback

extension HapticFeedback {
    // MARK: Public Instance Interface
    
    @inlinable
    public static func setIsDisabled(
        basedOn isDisabledKey: StorageKey<Bool>,
        userDefaults: UserDefaults = .standard
    ) {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isDisabledKey, userDefaults: userDefaults)
    }
    
    @inlinable
    public static func setIsEnabled(
        basedOn isEnabledKey: StorageKey<Bool>,
        userDefaults: UserDefaults = .standard
    ) {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isEnabledKey, userDefaults: userDefaults)
    }
}

// MARK: - Extension for HapticFeedbackGenerator

extension HapticFeedbackGenerator {
    // MARK: Public Initialization
    
    public convenience init(isDisabledKey: StorageKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isDisabledProvider: {
                userDefaults.get(isDisabledKey)
            }
        )
    }
    
    public convenience init(isEnabledKey: StorageKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isEnabledProvider: {
                userDefaults.get(isEnabledKey)
            }
        )
    }
    
    // MARK: Public Instance Interface
    
    public func setIsDisabled(basedOn isDisabledKey: StorageKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsDisabled {
            userDefaults.get(isDisabledKey)
        }
    }
    
    public func setIsEnabled(basedOn isEnabledKey: StorageKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsEnabled {
            userDefaults.get(isEnabledKey)
        }
    }
}

#endif
