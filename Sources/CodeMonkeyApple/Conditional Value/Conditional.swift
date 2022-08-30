//
//  Conditional.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public enum Conditional<TrueValue, FalseValue> {
    case `false`(FalseValue)
    case `true`(TrueValue)
}

// MARK: - Storable Extension

extension Conditional: Storable where TrueValue: Storable, FalseValue: Storable {
    // MARK: Public Typealiases
    
    public typealias StorableValue = Conditional<TrueValue.StorableValue, FalseValue.StorableValue>
    
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> StorableValue?) -> Self? {
        guard let storage = storage() else {
            return nil
        }
        
        switch storage {
        case let .false(storableValue):
            guard let value = FalseValue.decode(from: storableValue) else {
                return nil
            }
            
            return .false(value)
        case let .true(storableValue):
            guard let value = TrueValue.decode(from: storableValue) else {
                return nil
            }
            
            return .true(value)
        }
    }
    
    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> StorableValue {
        switch self {
        case let .false(value):
            return .false(value.encodeForStorage())
        case let .true(value):
            return .true(value.encodeForStorage())
        }
    }
}

// MARK: - StorageKeyProtocol Extension

extension Conditional: Identifiable, StorageKeyProtocol
where
    TrueValue: StorageKeyProtocol,
    FalseValue: StorageKeyProtocol
{
    // MARK: Public Typealiases
    
    public typealias Value = Conditional<TrueValue.Value, FalseValue.Value>
    
    // MARK: Public Instance Interface
    
    public var compositeIDs: Set<String> {
        [
            {
                switch self {
                case let .false(value):
                    return value.id
                case let .true(value):
                    return value.id
                }
            }()
        ]
    }
    
    public var defaultValue: Value {
        switch self {
        case let .false(value):
            return .false(value.defaultValue)
        case let .true(value):
            return .true(value.defaultValue)
        }
    }

    public func get(from userDefaults: UserDefaults) -> Value {
        switch self {
        case let .false(value):
            return .false(value.get(from: userDefaults))
        case let .true(value):
            return .true(value.get(from: userDefaults))
        }
    }

    public func remove(from userDefaults: UserDefaults) {
        switch self {
        case let .false(value):
            value.remove(from: userDefaults)
        case let .true(value):
            value.remove(from: userDefaults)
        }
    }

    public func set(to newValue: Value, in userDefaults: UserDefaults) {
        switch self {
        case let .false(key):
            switch newValue {
            case let .false(value):
                key.set(to: value, in: userDefaults)
            case .true:
                fatalError("Don't do this.")
            }
        case let .true(key):
            switch newValue {
            case .false:
                fatalError("Don't do this.")
            case let .true(value):
                key.set(to: value, in: userDefaults)
            }
        }
    }
    
    #if !os(watchOS)
    
    public func get(from ubiquitousStore: NSUbiquitousKeyValueStore) -> Value {
        switch self {
        case let .false(value):
            return .false(value.get(from: ubiquitousStore))
        case let .true(value):
            return .true(value.get(from: ubiquitousStore))
        }
    }
    
    public func remove(from ubiquitousStore: NSUbiquitousKeyValueStore) {
        switch self {
        case let .false(value):
            value.remove(from: ubiquitousStore)
        case let .true(value):
            value.remove(from: ubiquitousStore)
        }
    }
    
    public func set(to newValue: Value, in ubiquitousStore: NSUbiquitousKeyValueStore) {
        switch self {
        case let .false(key):
            switch newValue {
            case let .false(value):
                key.set(to: value, in: ubiquitousStore)
            case .true:
                fatalError("Don't do this.")
            }
        case let .true(key):
            switch newValue {
            case .false:
                fatalError("Don't do this.")
            case let .true(value):
                key.set(to: value, in: ubiquitousStore)
            }
        }
    }
    
    #endif
}
