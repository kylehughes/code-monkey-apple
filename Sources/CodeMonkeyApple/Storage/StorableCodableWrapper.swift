//
//  StorableCodableWrapper.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/16/22.
//

import Foundation

/// Prevents the need to manually implement Codable for all of the types that we want to store in `@AppStorage` as
/// `RawRepresentable` `String`s.
@dynamicMemberLookup
public struct StorableCodableWrapper<Value> where Value: Codable {
    public let storedValue: Value
    
    // MARK: Public Initialization
    
    public init(_ storedValue: Value) {
        self.storedValue = storedValue
    }
    
    // MARK: Public Subscripts
    
    public subscript<PropertyValue>(dynamicMember keyPath: KeyPath<Value, PropertyValue>) -> PropertyValue {
        storedValue[keyPath: keyPath]
    }
}

// MARK: - Decodable Extension

extension StorableCodableWrapper: Decodable {
    // MARK: Public Initialization
    
    public init(from decoder: Decoder) throws {
        storedValue = try Value(from: decoder)
    }
}

// MARK: - Encodable Extension

extension StorableCodableWrapper: Encodable {
    // MARK: Public Instance Interface
    
    public func encode(to encoder: Encoder) throws {
        try storedValue.encode(to: encoder)
    }
}

// MARK: - RawRepresentable Extension

extension StorableCodableWrapper: RawRepresentable {
    // MARK: Public Initialization
    
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let color = try? JSONDecoder.default.decode(Self.self, from: data)
        else {
            return nil
        }
        
        self = color
    }
    
    // MARK: Public Instance Interface
    
    public var rawValue: String {
        try! String(data: JSONEncoder.default.encode(self), encoding: .utf8)!
    }
}
