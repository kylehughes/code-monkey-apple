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
    public func get<Value>(_ key: StorageKey<Value>) -> Value {
        .decode(for: key, from: Value.extract(key, from: self))
    }
    
    @inlinable
    public func get<Value>(_ key: DebugStorageKey<Value>) -> Value {
        #if DEBUG
        .decode(for: key, from: Value.extract(key, from: self))
        #else
        key.defaultValue
        #endif
    }
    
    // MARK: Setting Values
    
    @inlinable
    public func set<Value>(_ key: StorageKey<Value>, to value: Value) {
        value.store(value.encodeForStorage(), as: key.id, in: self)
    }
    
    @inlinable
    public func set<Value>(_ key: DebugStorageKey<Value>, to value: Value) {
        #if DEBUG
        value.store(value.encodeForStorage(), as: key.id, in: self)
        #else
        // NO-OP
        #endif
    }
    
    // MARK: Removing Values

    @inlinable
    public func remove<Value>(_ key: StorageKey<Value>) {
        removeObject(forKey: key.id)
    }

    @inlinable
    public func remove<Value>(_ key: DebugStorageKey<Value>) {
        #if DEBUG
        removeObject(forKey: key.id)
        #else
        // NO-OP
        #endif
    }
}
