//
//  StoredValue.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/21/22.
//

import Combine
import Foundation
import SwiftUI

@propertyWrapper
public struct StoredValue<Value>: DynamicProperty where Value: Storable {
    @StateObject private var observer: UserDefaultsStorageKeyObserver<KeyStorage>
    
    private let key: KeyStorage
    private let storage: UserDefaults
    
    // MARK: Public Initialization
    
    public init(_ key: DebugStorageKey<Value>, storage: UserDefaults = .standard) {
        let key = KeyStorage.debug(key)
        self.key = key
        self.storage = storage
        
        _observer = StateObject(wrappedValue: UserDefaultsStorageKeyObserver(key: key, storage: storage))
    }
    
    public init(_ key: StorageKey<Value>, storage: UserDefaults = .standard) {
        let key = KeyStorage.release(key)
        self.key = key
        self.storage = storage
        
        _observer = StateObject(wrappedValue: UserDefaultsStorageKeyObserver(key: key, storage: storage))
    }
    
    // MARK: Property Wrapper Implementation
    
    public var projectedValue: Binding<Value> {
        Binding {
            wrappedValue
        } set: {
            wrappedValue = $0
        }
    }
    
    public var wrappedValue: Value {
        get {
            switch key {
            case let .debug(key):
                return storage.get(key)
            case let .release(key):
                return storage.get(key)
            }
        }
        nonmutating set {
            switch key {
            case let .debug(key):
                storage.set(key, to: newValue)
            case let .release(key):
                storage.set(key, to: newValue)
            }
        }
    }
}

// MARK: - StoredValue.KeyStorage Definition

extension StoredValue {
    enum KeyStorage {
        case debug(DebugStorageKey<Value>)
        case release(StorageKey<Value>)
    }
}

// MARK: - StorageKeyProtocol Extension

extension StoredValue.KeyStorage: StorageKeyProtocol {
    // MARK: Internal Instance Interface
    
    var defaultValue: Value {
        switch self {
        case let .debug(key):
            return key.defaultValue
        case let .release(key):
            return key.defaultValue
        }
    }
    
    var id: String {
        switch self {
        case let .debug(key):
            return key.id
        case let .release(key):
            return key.id
        }
    }
}
