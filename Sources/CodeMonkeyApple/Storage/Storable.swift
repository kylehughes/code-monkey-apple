//
//  Storable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/29/22.
//

import Foundation

public protocol Storable {
    associatedtype StorableValue
    
    // MARK: Static Interface

    static func decode(from storage: @autoclosure () -> StorableValue?) -> Self?
    
    // MARK: Instance Interface
    
    func encodeForStorage() -> StorableValue
}

extension Storable {
    // MARK: Public Static Interface
    
    public static func decode(for key: StorageKey<Self>, from storage: @autoclosure () -> Any?) -> Self {
        guard let storableValue = storage() as? StorableValue else {
            return key.defaultValue
        }
        
        return decode(for: key, from: storableValue)
    }
    
    public static func decode(for key: StorageKey<Self>, from storage: @autoclosure () -> StorableValue?) -> Self {
        decode(from: storage()) ?? key.defaultValue
    }
}

// MARK: - Extension for Bool

extension Bool: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for Data

extension Data: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for Date

extension Date: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> TimeInterval?) -> Self? {
        guard let storableValue = storage() else {
            return nil
        }
        
        return Date(timeIntervalSince1970: storableValue)
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> TimeInterval {
        timeIntervalSince1970
    }
}

// MARK: - Extension for Double

extension Double: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for Float

extension Float: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for Int

extension Int: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for String

extension String: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for [String]

extension Array: Storable where Element == String {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for URL

extension URL: Storable {
    // MARK: Public Static Interface
    
    @inlinable
    public static func decode(from storage: @autoclosure () -> Self?) -> Self? {
        storage()
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public func encodeForStorage() -> Self {
        self
    }
}

// MARK: - Extension for Optionals of Supported Types

extension Optional: Storable where Wrapped: Storable {
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> Wrapped.StorableValue??) -> Wrapped?? {
        guard let wrappedStorableValue = storage(), let unwrappedStorableValue = wrappedStorableValue else {
            return nil
        }
        
        return Wrapped.decode(from: unwrappedStorableValue)
    }

    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> Wrapped.StorableValue? {
        switch self {
        case .none:
            return nil
        case let .some(wrapped):
            return wrapped.encodeForStorage()
        }
    }
}
