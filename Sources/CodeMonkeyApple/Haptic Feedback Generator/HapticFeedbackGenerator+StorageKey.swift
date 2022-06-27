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
    public static func setIsDisabled<Key>(
        basedOn isDisabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isDisabledKey, storage: storage)
    }
    
    @inlinable
    public static func setIsEnabled<Key>(
        basedOn isEnabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isEnabledKey, storage: storage)
    }
}

// MARK: - Extension for HapticFeedbackGenerator

extension HapticFeedbackGenerator {
    // MARK: Public Initialization
    
    public convenience init<Key>(
        isDisabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        self.init(
            isDisabledProvider: {
                storage.get(isDisabledKey)
            }
        )
    }
    
    public convenience init<Key>(
        isEnabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        self.init(
            isEnabledProvider: {
                storage.get(isEnabledKey)
            }
        )
    }
    
    // MARK: Public Instance Interface
    
    public func setIsDisabled<Key>(
        basedOn isDisabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        setIsDisabled {
            storage.get(isDisabledKey)
        }
    }
    
    public func setIsEnabled<Key>(
        basedOn isEnabledKey: Key,
        storage: Storage
    ) where Key: StorageKeyProtocol, Key.Value == Bool {
        setIsEnabled {
            storage.get(isEnabledKey)
        }
    }
}

#endif
