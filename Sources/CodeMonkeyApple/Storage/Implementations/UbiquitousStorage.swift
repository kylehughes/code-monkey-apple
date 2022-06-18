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
    
    // MARK: Observing Keys
    
    @inlinable
    public func deregister<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?
    ) where Key: StorageKeyProtocol {
        NotificationCenter.default.removeObserver(
            self,
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: self
        )
    }
    
    @inlinable
    public func register<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?,
        valueWillChange: @escaping () -> Void
    ) where Key: StorageKeyProtocol {
        NotificationCenter.default.addObserver(
            forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: self,
            queue: nil
        ) { notification in
            let userInfoKey = AnyHashable(NSUbiquitousKeyValueStoreChangedKeysKey)
            
            guard let changedKeyIDs = notification.userInfo?[userInfoKey] as? [String] else {
                return
            }
            
            let changedKeyIDsSet = Set(changedKeyIDs)
            
            guard not(changedKeyIDsSet.union(key.compositeIDs).isEmpty) else {
                return
            }
            
            valueWillChange()
        }
    }
}
