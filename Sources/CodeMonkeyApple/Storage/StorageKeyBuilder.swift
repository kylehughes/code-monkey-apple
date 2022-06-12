//
//  StorageKeyBuilder.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

@resultBuilder
public struct StorageKeyBuilder {
    // NO-OP
}

// MARK: - Statement Blocks

extension StorageKeyBuilder {
    // MARK: Public Static Interface
    
    public static func buildBlock() -> StorageKey<Int?> {
        StorageKey(id: "TODO", defaultValue: nil)
    }
    
    public static func buildBlock<K1>(_ k1: K1) -> K1 where K1: StorageKeyProtocol {
        k1
    }
    
    public static func buildBlock<K1, K2>(
        _ k1: K1,
        _ k2: K2
    ) -> Tuple2<K1, K2>
    where
        K1: StorageKeyProtocol,
        K2: StorageKeyProtocol
    {
        Tuple2(k1, k2)
    }
    
    public static func buildBlock<K1, K2, K3>(
        _ k1: K1,
        _ k2: K2,
        _ k3: K3
    ) -> Tuple3<K1, K2, K3>
    where
        K1: StorageKeyProtocol,
        K2: StorageKeyProtocol,
        K3: StorageKeyProtocol
    {
        Tuple3(k1, k2, k3)
    }
}

// MARK: - Optionals

extension StorageKeyBuilder {
    // MARK: Public Static Interface
    
    public static func buildIf<Key>(_ key: Key?) -> Key? {
        key
    }
}

// MARK: - Conditionals

extension StorageKeyBuilder {
    // MARK: Public Static Interface
    
    public static func buildEither<TrueKey, FalseKey>(
        first: TrueKey
    ) -> Conditional<TrueKey, FalseKey> where TrueKey: StorageKeyProtocol, FalseKey: StorageKeyProtocol {
        .true(first)
    }
    
    public static func buildEither<TrueKey, FalseKey>(
        second: FalseKey
    ) -> Conditional<TrueKey, FalseKey> where TrueKey: StorageKeyProtocol, FalseKey: StorageKeyProtocol {
        .false(second)
    }
}

// MARK: - Expressions

extension StorageKeyBuilder {
    // NO-OP, can be implemented by consumer if desired
}

// MARK: - Final Results

extension StorageKeyBuilder {
    // NO-OP, can be implemented by consumer if desired
}

// MARK: - Limited Availability

extension StorageKeyBuilder {
    // MARK: Public Static Interface
    
    public static func buildLimitedAvailability<Key>(_ key: Key) -> Key where Key: StorageKeyProtocol {
        key
    }
}
