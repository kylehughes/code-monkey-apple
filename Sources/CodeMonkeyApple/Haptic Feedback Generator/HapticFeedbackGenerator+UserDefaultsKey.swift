//
//  HapticFeedbackGenerator+UserDefaultsKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/3/21.
//

#if canImport(UIKit)

import UIKit

extension HapticFeedbackGenerator {
    // MARK: Public Initialization
    
    public convenience init(isDisabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isDisabledProvider: {
                userDefaults.getValue(for: isDisabledKey)
            }
        )
    }
    
    public convenience init(isEnabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isEnabledProvider: {
                userDefaults.getValue(for: isEnabledKey)
            }
        )
    }
    
    // MARK: Public Instance Interface
    
    public func setIsDisabled(basedOn isDisabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsDisabled {
            userDefaults.getValue(for: isDisabledKey)
        }
    }
    
    public func setIsEnabled(basedOn isEnabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsEnabled {
            userDefaults.getValue(for: isEnabledKey)
        }
    }
}

#endif
