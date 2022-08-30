//
//  Tuple3.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public struct Tuple3<E1, E2, E3> {
    public let e1: E1
    public let e2: E2
    public let e3: E3
    
    // MARK: Public Initialization
    
    public init(
        _ e1: E1,
        _ e2: E2,
        _ e3: E3
    ) {
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
    }
}

// MARK: - Equatable Extension

extension Tuple3: Equatable
where
    E1: Equatable,
    E2: Equatable,
    E3: Equatable
{
    // NO-OP
}

// MARK: - Hashable Extension

extension Tuple3: Hashable
where
    E1: Hashable,
    E2: Hashable,
    E3: Hashable
{
    // NO-OP
}

// MARK: - Storable Extension

extension Tuple3: Storable
where
    E1: Storable,
    E2: Storable,
    E3: Storable
{
    // MARK: Public Typealiases
    
    public typealias StorableValue = (
        E1.StorableValue,
        E2.StorableValue,
        E3.StorableValue
    )
    
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        guard
            let (
                storedE1,
                storedE2,
                storedE3
            ) = storage(),
            let e1 = E1.decode(from: storedE1),
            let e2 = E2.decode(from: storedE2),
            let e3 = E3.decode(from: storedE3)
        else {
            return nil
        }
        
        return Self(
            e1,
            e2,
            e3
        )
    }
    
    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> StorableValue {
        (
            e1.encodeForStorage(),
            e2.encodeForStorage(),
            e3.encodeForStorage()
        )
    }
}

// MARK: - StorageKeyProtocol Extension

extension Tuple3: Identifiable, StorageKeyProtocol
where
    E1: StorageKeyProtocol,
    E2: StorageKeyProtocol,
    E3: StorageKeyProtocol
{
    // MARK: Public Typealiases
    
    public typealias Value = Tuple3<
        E1.Value,
        E2.Value,
        E3.Value
    >
    
    // MARK: Public Instance Interface
    
    public var compositeIDs: Set<String> {
        [
            e1.id,
            e2.id,
            e3.id,
        ]
    }
    
    public var defaultValue: Value {
        Value(
            e1.defaultValue,
            e2.defaultValue,
            e3.defaultValue
        )
    }

    public func get(from userDefaults: UserDefaults) -> Value {
        Value(
            e1.get(from: userDefaults),
            e2.get(from: userDefaults),
            e3.get(from: userDefaults)
        )
    }
    
    public func remove(from userDefaults: UserDefaults) {
        e1.remove(from: userDefaults)
        e2.remove(from: userDefaults)
        e3.remove(from: userDefaults)
    }

    public func set(to newValue: Value, in userDefaults: UserDefaults) {
        e1.set(to: newValue.e1, in: userDefaults)
        e2.set(to: newValue.e2, in: userDefaults)
        e3.set(to: newValue.e3, in: userDefaults)
    }
    
    #if !os(watchOS)
    
    public func get(from ubiquitousStore: NSUbiquitousKeyValueStore) -> Value {
        Value(
            e1.get(from: ubiquitousStore),
            e2.get(from: ubiquitousStore),
            e3.get(from: ubiquitousStore)
        )
    }
    
    public func remove(from ubiquitousStore: NSUbiquitousKeyValueStore) {
        e1.remove(from: ubiquitousStore)
        e2.remove(from: ubiquitousStore)
        e3.remove(from: ubiquitousStore)
    }

    public func set(to newValue: Value, in ubiquitousStore: NSUbiquitousKeyValueStore) {
        e1.set(to: newValue.e1, in: ubiquitousStore)
        e2.set(to: newValue.e2, in: ubiquitousStore)
        e3.set(to: newValue.e3, in: ubiquitousStore)
    }
    
    #endif
}
