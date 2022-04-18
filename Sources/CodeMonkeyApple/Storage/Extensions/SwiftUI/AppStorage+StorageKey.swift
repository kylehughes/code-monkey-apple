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
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Bool {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Bool? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Data {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Data? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Double {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Double? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Int {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == Int? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == String {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == String? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == URL {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value == URL? {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value: RawRepresentable, Value.RawValue == Int {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key, Representable>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where
        Key: StorageKeyProtocol,
        Key.Value == Value,
        Value == Representable?,
        Representable: RawRepresentable,
        Representable.RawValue == Int
    {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value == Value, Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: key.defaultValue, key.id, store: storage)
    }
    
    @inlinable
    public init<Key, Representable>(
        _ key: Key,
        storage: UserDefaults = .standard
    ) where
        Key: StorageKeyProtocol,
        Key.Value == Value,
        Value == Representable?,
        Representable: RawRepresentable,
        Representable.RawValue == String
    {
        self.init(key.id, store: storage)
    }
    
    @inlinable
    public init<Key>(
        wrapping key: Key,
        storage: UserDefaults = .standard
    ) where Key: StorageKeyProtocol, Key.Value: Codable, Value == StorableCodableWrapper<Key.Value> {
        self.init(wrappedValue: StorableCodableWrapper(key.defaultValue), key.id, store: storage)
    }
}
