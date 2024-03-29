//
//  StorageKey.swift
//  Storage
//
//  Created by Kyle Hughes on 3/28/22.
//

import Foundation

public struct StorageKey<Value>: Identifiable where Value: Storable {
    public let defaultValue: Value
    public let id: String
    
    // MARK: Public Initialization
    
    public init(id: String, defaultValue: Value) {
        self.id = id
        self.defaultValue = defaultValue
    }
}

// MARK: - Conditional Codable Extension

extension StorageKey: Codable where Value: Codable {
    // NO-OP
}

// MARK: - Conditional Equatable Extension

extension StorageKey: Equatable where Value: Equatable {
    // NO-OP
}

// MARK: - Conditional Hashable Extension

extension StorageKey: Hashable where Value: Hashable {
    // NO-OP
}

// MARK: - StorageKeyProtocol Extension

extension StorageKey: StorageKeyProtocol {
    // MARK: Public Instance Interface
    
    public var compositeIDs: Set<String> {
        [id]
    }
    
    public func get(from userDefaults: UserDefaults) -> Value {
        .decode(for: self, from: Value.extract(self, from: userDefaults))
    }
    
    public func remove(from userDefaults: UserDefaults) {
        userDefaults.removeObject(forKey: id)
    }
    
    public func set(to newValue: Value, in userDefaults: UserDefaults) {
        newValue.store(newValue.encodeForStorage(), as: id, in: userDefaults)
    }
    
    #if !os(watchOS)
    
    public func get(from ubiquitousStore: NSUbiquitousKeyValueStore) -> Value {
        .decode(for: self, from: Value.extract(self, from: ubiquitousStore))
    }
    
    public func remove(from ubiquitousStore: NSUbiquitousKeyValueStore) {
        ubiquitousStore.removeObject(forKey: id)
    }
    
    public func set(to newValue: Value, in ubiquitousStore: NSUbiquitousKeyValueStore) {
        newValue.store(newValue.encodeForStorage(), as: id, in: ubiquitousStore)
    }
    
    #endif
}
