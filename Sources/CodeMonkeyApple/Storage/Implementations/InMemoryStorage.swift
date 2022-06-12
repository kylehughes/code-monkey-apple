//
//  InMemoryStorage.swift
//  Super Headache
//
//  Created by Kyle Hughes on 3/23/21.
//

import Foundation

public final class InMemoryStorage {
    private var storage: [String: Any]
    
    // MARK: Public Initialization
    
    public init() {
        storage = [:]
    }
    
    // MARK: Private Instance Interface
    
    private subscript(key: String) -> Any? {
        get {
            storage[key]
        }
        set {
            storage[key] = newValue
        }
    }
}

// MARK: - Storage Extension

extension InMemoryStorage: Storage {
    // MARK: Getting Values
    
    public func get<Value>(_ key: StorageKey<Value>) -> Value {
        self[key.id] as? Value ?? key.defaultValue
    }
    
    // MARK: Getting Debug Values
    
    public func get<Value>(_ key: DebugStorageKey<Value>) -> Value {
        #if DEBUG
        self[key.id] as? Value ?? key.defaultValue
        #else
        key.defaultValue
        #endif
    }
    
    // MARK: Setting Values

    public func set<Value>(_ key: StorageKey<Value>, to value: Value) {
        self[key.id] = value
    }
    
    // MARK: Setting Debug Values
    
    public func set<Value>(_ key: DebugStorageKey<Value>, to value: Value) {
        #if DEBUG
        self[key.id] = value
        #else
        // NO-OP
        #endif
    }
    
    // MARK: Removing Values
    
    public func remove<Value>(_ key: StorageKey<Value>) {
        storage.removeValue(forKey: key.id)
    }
    
    // MARK: Removing Debug Values
    
    public func remove<Value>(_ key: DebugStorageKey<Value>) where Value : Storable {
        #if DEBUG
        storage.removeValue(forKey: key.id)
        #else
        // NO-OP
        #endif
    }
}

#if DEBUG
// MARK: - Previews

extension InMemoryStorage {
    // MARK: Public Static Interface
    
    public static let preview = InMemoryStorage()
}
#endif
