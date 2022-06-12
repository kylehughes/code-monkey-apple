//
//  Tuple2.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public struct Tuple2<E1, E2> {
    public let e1: E1
    public let e2: E2
    
    // MARK: Public Initialization
    
    public init(
        _ e1: E1,
        _ e2: E2
    ) {
        self.e1 = e1
        self.e2 = e2
    }
}

// MARK: - Equatable Extension

extension Tuple2: Equatable
where
    E1: Equatable,
    E2: Equatable
{
    // NO-OP
}

// MARK: - Hashable Extension

extension Tuple2: Hashable
where
    E1: Hashable,
    E2: Hashable
{
    // NO-OP
}

// MARK: - Storable Extension

extension Tuple2: Storable
where
    E1: Storable,
    E2: Storable
{
    // MARK: Public Typealiases
    
    public typealias StorableValue = (
        E1.StorableValue,
        E2.StorableValue
    )
    
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        guard
            let (
                storedE1,
                storedE2
            ) = storage(),
            let e1 = E1.decode(from: storedE1),
            let e2 = E2.decode(from: storedE2)
        else {
            return nil
        }
        
        return Self(
            e1,
            e2
        )
    }
    
    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> StorableValue {
        (
            e1.encodeForStorage(),
            e2.encodeForStorage()
        )
    }
}

// MARK: - StorageKeyProtocol Extension

extension Tuple2: Identifiable, StorageKeyProtocol
where
    E1: StorageKeyProtocol,
    E2: StorageKeyProtocol
{
    // MARK: Public Typealiases
    
    public typealias Value = Tuple2<
        E1.Value,
        E2.Value
    >
    
    // MARK: Public Instance Interface
    
    public var defaultValue: Value {
        Value(
            e1.defaultValue,
            e2.defaultValue
        )
    }
    
    public var id: String {
        [
            e1.id,
            e2.id,
        ]
        .joined(separator: ",")
    }

    public func get(from ubiquitousStore: NSUbiquitousKeyValueStore) -> Value {
        Value(
            e1.get(from: ubiquitousStore),
            e2.get(from: ubiquitousStore)
        )
    }

    public func get(from userDefaults: UserDefaults) -> Value {
        Value(
            e1.get(from: userDefaults),
            e2.get(from: userDefaults)
        )
    }

    public func remove(from ubiquitousStore: NSUbiquitousKeyValueStore) {
        e1.remove(from: ubiquitousStore)
        e2.remove(from: ubiquitousStore)
    }

    public func remove(from userDefaults: UserDefaults) {
        e1.remove(from: userDefaults)
        e2.remove(from: userDefaults)
    }

    public func set(to newValue: Value, in ubiquitousStore: NSUbiquitousKeyValueStore) {
        e1.set(to: newValue.e1, in: ubiquitousStore)
        e2.set(to: newValue.e2, in: ubiquitousStore)
    }

    public func set(to newValue: Value, in userDefaults: UserDefaults) {
        e1.set(to: newValue.e1, in: userDefaults)
        e2.set(to: newValue.e2, in: userDefaults)
    }
}
