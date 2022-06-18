//
//  UserDefaultsStorage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

import Foundation

extension UserDefaults: Storage {
    // MARK: Getting Values
    
    @inlinable
    public func get<Key>(_ key: Key) -> Key.Value where Key: StorageKeyProtocol {
        key.get(from: self)
    }
    
    // MARK: Setting Values
    
    @inlinable
    public func set<Key>(_ key: Key, to value: Key.Value) where Key: StorageKeyProtocol {
        key.set(to: value, in: self)
    }
    
    // MARK: Removing Values
    
    @inlinable
    public func remove<Key>(_ key: Key) where Key: StorageKeyProtocol {
        key.remove(from: self)
    }
    
    // MARK: Observing Keys
    
    public func deregister<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?
    ) where Key: StorageKeyProtocol {
        for keyID in key.compositeIDs {
            removeObserver(target, forKeyPath: keyID, context: context)
        }
    }
    
    public func register<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?,
        valueWillChange: () -> Void
    ) where Key: StorageKeyProtocol {
        for keyID in key.compositeIDs {
            addObserver(target, forKeyPath: keyID, context: context)
        }
    }
}
