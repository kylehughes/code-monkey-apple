//
//  UserDefaultsKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/27/21.
//

public struct UserDefaultsKey<Value> {
    public let defaultValue: Value
    public let key: String
    
    // MARK: Public Initialization
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

// MARK: - Identifiable Extension

extension UserDefaultsKey: Identifiable {
    // MARK: Public Instance Interface
    
    public var id: String {
        key
    }
}

// MARK: - Conditional Codable Extension

extension UserDefaultsKey: Codable where Value: Codable {
    // NO-OP
}

// MARK: - Conditional Equatable Extension

extension UserDefaultsKey: Equatable where Value: Equatable {
    // NO-OP
}

// MARK: - Conditional Hashable Extension

extension UserDefaultsKey: Hashable where Value: Hashable {
    // NO-OP
}
