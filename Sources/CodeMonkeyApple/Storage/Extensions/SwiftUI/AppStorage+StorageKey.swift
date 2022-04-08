//
//  AppStorage+StorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/7/22.
//

import SwiftUI

extension AppStorage {
    // MARK: Public Initialization
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == Bool, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == Data, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == Double, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == Int, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == String, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
    
    @inlinable
    public init<StorageValue>(
        _ key: StorageKey<StorageValue>
    ) where Value == URL, StorageValue.StorableValue == Value {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
}
