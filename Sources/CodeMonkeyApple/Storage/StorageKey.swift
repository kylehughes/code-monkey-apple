//
//  StorageKey.swift
//  Storage
//
//  Created by Kyle Hughes on 3/28/22.
//

public struct StorageKey<Value>: Identifiable, StorageKeyProtocol where Value: Storable {
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
