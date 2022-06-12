//
//  UbquitousStorage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/11/22.
//

import Foundation

extension NSUbiquitousKeyValueStore: Storage {
    // MARK: Getting Values
    
    @inlinable
    public func get<Key>(_ key: Key) -> Key.Value where Key : StorageKeyProtocol {
        key.get(from: self)
    }
    
    // MARK: Setting Values
    
    @inlinable
    public func set<Key>(_ key: Key, to value: Key.Value) where Key : StorageKeyProtocol {
        key.set(to: value, in: self)
    }
    
    // MARK: Removing Values

    @inlinable
    public func remove<Key>(_ key: Key) where Key: StorageKeyProtocol {
        key.remove(from: self)
    }
}
