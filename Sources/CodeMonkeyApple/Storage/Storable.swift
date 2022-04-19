//
//  Storable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/29/22.
//

import Foundation

public protocol Storable {
    // MARK: Associated Types
    
    associatedtype StorableValue
    
    // MARK: Converting to and From Storable Value

    static func decode(from storage: @autoclosure () -> StorableValue?) -> Self?
    
    func encodeForStorage() -> StorableValue
    
    // MARK: Interfacing With User Defaults
    
    static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue?
    
    func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults)
}

// MARK: - Default Implementation

extension Storable {
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
    
    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.object(forKey: userDefaultsKey) as? StorableValue
    }
}

// MARK: - Novel Implementation

extension Storable {
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode<Key>(
        for key: Key,
        from storage: @autoclosure () -> StorableValue?
    ) -> Self where Key: StorageKeyProtocol, Key.Value == Self {
        decode(from: storage()) ?? key.defaultValue
    }
    
    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract<Key>(
        _ key: Key,
        from userDefaults: UserDefaults
    ) -> StorableValue? where Key: StorageKeyProtocol {
        extract(key.id, from: userDefaults)
    }
}

// MARK: - Extension for Bool

extension Bool: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        // We use the default implementation with `object(forKey)` so that we can differentiate a `nil` value from
        // a `false` value.
        userDefaults.object(forKey: userDefaultsKey) as? StorableValue
    }
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Data

extension Data: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.data(forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Date

extension Date: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = TimeInterval
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        guard let storableValue = storage() else {
            return nil
        }
        
        return Date(timeIntervalSince1970: storableValue)
    }
    
    @inlinable
    public func encodeForStorage() -> TimeInterval {
        timeIntervalSince1970
    }
    
    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.double(forKey: userDefaultsKey)
    }

    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Double

extension Double: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        // We use the default implementation with `object(forKey)` so that we can differentiate a `nil` value from
        // a 0 value.
        userDefaults.object(forKey: userDefaultsKey) as? StorableValue
    }

    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Float

extension Float: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
    
    // MARK: Interfacing With User Defaults
    
    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        // We use the default implementation with `object(forKey)` so that we can differentiate a `nil` value from
        // a 0 value.
        userDefaults.object(forKey: userDefaultsKey) as? StorableValue
    }
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Int

extension Int: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        // We use the default implementation with `object(forKey)` so that we can differentiate a `nil` value from
        // a 0 value.
        userDefaults.object(forKey: userDefaultsKey) as? StorableValue
    }
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for String

extension String: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.string(forKey: userDefaultsKey)
    }
}

// MARK: - Extension for [String]

extension Array: Storable where Element == String {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.stringArray(forKey: userDefaultsKey)
    }
}

// MARK: - Extension for URL

extension URL: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Self
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        userDefaults.url(forKey: userDefaultsKey)
    }
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: userDefaultsKey)
    }
}

// MARK: - Extension for Optionals of Supported Types

extension Optional: Storable where Wrapped: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Wrapped.StorableValue?
    
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        guard let wrappedStorableValue = storage(), let unwrappedStorableValue = wrappedStorableValue else {
            return nil
        }
        
        return Wrapped.decode(from: unwrappedStorableValue)
    }
    
    @inlinable
    public func encodeForStorage() -> StorableValue {
        switch self {
        case .none:
            return nil
        case let .some(wrapped):
            return wrapped.encodeForStorage()
        }
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> StorableValue? {
        Wrapped.extract(userDefaultsKey, from: userDefaults)
    }
    
    @inlinable
    public func store(_ value: StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        switch self {
        case .none:
            userDefaults.removeObject(forKey: userDefaultsKey)
        case let .some(wrapped):
            wrapped.store(wrapped.encodeForStorage(), as: userDefaultsKey, in: userDefaults)
        }
    }
}

// MARK: - Extension for RawRepresentables of Supported Types

extension Storable where Self: RawRepresentable, RawValue: Storable, StorableValue == RawValue.StorableValue {
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> RawValue.StorableValue?) -> Self? {
        guard let rawValue = RawValue.decode(from: storage()), let value = Self(rawValue: rawValue) else {
            return nil
        }
        
        return value
    }
    
    @inlinable
    public func encodeForStorage() -> RawValue.StorableValue {
        rawValue.encodeForStorage()
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> RawValue.StorableValue? {
        RawValue.extract(userDefaultsKey, from: userDefaults)
    }
    
    @inlinable
    public func store(_ value: RawValue.StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        rawValue.store(value, as: userDefaultsKey, in: userDefaults)
    }
}

// MARK: - Extension for Codable Types

extension Storable where Self: Codable, StorableValue == String {
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> String?) -> Self? {
        guard
            let jsonString = storage(),
            let json = jsonString.data(using: .utf8),
            let value = try? JSONDecoder.default.decode(Self.self, from: json)
        else {
            return nil
        }
        
        return value
    }
    
    @inlinable
    public func encodeForStorage() -> String {
        String(data: try! JSONEncoder.default.encode(self), encoding: .utf8)!
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> String? {
        .extract(userDefaultsKey, from: userDefaults)
    }
}

// MARK: - Extension for Raw Representable & Codable Types (Conflict-Avoidance)

extension Storable where Self: Codable & RawRepresentable, RawValue == String, StorableValue == String {
    // MARK: Converting to and From Storable Value
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> RawValue.StorableValue?) -> Self? {
        guard let rawValue = RawValue.decode(from: storage()), let value = Self(rawValue: rawValue) else {
            return nil
        }
        
        return value
    }
    
    @inlinable
    public func encodeForStorage() -> RawValue.StorableValue {
        rawValue.encodeForStorage()
    }

    // MARK: Interfacing With User Defaults

    @inlinable
    public static func extract(_ userDefaultsKey: String, from userDefaults: UserDefaults) -> RawValue.StorableValue? {
        RawValue.extract(userDefaultsKey, from: userDefaults)
    }
    
    @inlinable
    public func store(_ value: RawValue.StorableValue, as userDefaultsKey: String, in userDefaults: UserDefaults) {
        rawValue.store(value, as: userDefaultsKey, in: userDefaults)
    }
}
