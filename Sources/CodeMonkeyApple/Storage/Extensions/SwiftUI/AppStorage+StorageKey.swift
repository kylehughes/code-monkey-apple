//
//  AppStorage+StorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/7/22.
//

import SwiftUI

extension AppStorage {
    // MARK: Initialize With Storage Key
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Bool {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Data {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Double {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Int {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == String {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == URL {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value: RawRepresentable, Value.RawValue == Int {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init<Key>(
        wrapping key: Key
    ) where Key: StorageKeyProtocol, Key.Value: Codable, Value == StorableCodableWrapper<Key.Value> {
        self.init(wrappedValue: StorableCodableWrapper(key.defaultValue), key.id)
    }
}
