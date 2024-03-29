//
//  UbquitousStorage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/11/22.
//

import Foundation

#if !os(watchOS)

extension NSUbiquitousKeyValueStore: Storage {
    public static let didChangeInternallyNotification = NSNotification.Name(
        "NSUbiquitousKeyValueStore.DidChangeInternally"
    )
    
    // MARK: Getting Values
    
    @inlinable
    public func get<Key>(_ key: Key) -> Key.Value where Key : StorageKeyProtocol {
        key.get(from: self)
    }
    
    // MARK: Setting Values
    
    @inlinable
    public func set<Key>(_ key: Key, to value: Key.Value) where Key : StorageKeyProtocol {
        key.set(to: value, in: self)
        
        postInternalChangeNotification(for: key)
    }
    
    // MARK: Removing Values

    @inlinable
    public func remove<Key>(_ key: Key) where Key: StorageKeyProtocol {
        key.remove(from: self)
        
        postInternalChangeNotification(for: key)
    }
    
    // MARK: Observing Keys
    
    @inlinable
    public func deregister<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?
    ) where Key: StorageKeyProtocol {
        NotificationCenter.default.removeObserver(self, name: Self.didChangeExternallyNotification, object: self)
        NotificationCenter.default.removeObserver(self, name: Self.didChangeInternallyNotification, object: self)
    }
    
    @inlinable
    public func register<Key>(
        observer target: NSObject,
        for key: Key,
        with context: UnsafeMutableRawPointer?,
        valueWillChange: @escaping () -> Void
    ) where Key: StorageKeyProtocol {
        NotificationCenter.default.addObserver(
            forName: Self.didChangeExternallyNotification,
            object: self,
            queue: nil
        ) {
            self.didObserveChange(for: key, via: $0, valueWillChange: valueWillChange)
        }
        
        NotificationCenter.default.addObserver(
            forName: Self.didChangeInternallyNotification,
            object: self,
            queue: nil
        ) {
            self.didObserveChange(for: key, via: $0, valueWillChange: valueWillChange)
        }
    }
    
    // MARK: Internal Instance Interface
    
    internal static let changedKeysKey = AnyHashable(NSUbiquitousKeyValueStoreChangedKeysKey)
    
    @usableFromInline
    internal func didObserveChange<Key>(
        for key: Key,
        via notification: Notification,
        valueWillChange: @escaping () -> Void
    ) where Key: StorageKeyProtocol {
        guard let changedKeyIDs = notification.userInfo?[Self.changedKeysKey] as? [String] else {
            return
        }
        
        let changedKeyIDsSet = Set(changedKeyIDs)
        
        guard not(changedKeyIDsSet.union(key.compositeIDs).isEmpty) else {
            return
        }
        
        valueWillChange()
    }
    
    @usableFromInline
    internal func postInternalChangeNotification<Key>(for key: Key) where Key: StorageKeyProtocol {
        NotificationCenter.default.post(
            name: Self.didChangeInternallyNotification,
            object: self,
            userInfo: [
                Self.changedKeysKey: Array(key.compositeIDs)
            ]
        )
    }
}

#endif
