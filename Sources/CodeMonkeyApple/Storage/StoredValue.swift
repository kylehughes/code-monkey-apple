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
public struct StoredValue<Storage, Key>: DynamicProperty
where
    Storage: CodeMonkeyApple.Storage,
    Key: StorageKeyProtocol
{
    @StateObject private var observer: StorageKeyObserver<Storage, Key>
    
    private let key: Key
    private let storage: Storage
    
    // MARK: Public Initialization
    
    public init(_ key: Key, storage: Storage = .default) where Storage == NSUbiquitousKeyValueStore {
        self.init(key, storage: storage, observer: UbiquitousStorageKeyObserver(storage: storage, key: key))
    }
    
    public init(_ key: Key, storage: Storage = .standard) where Storage == UserDefaults {
        self.init(key, storage: storage, observer: UserDefaultsStorageKeyObserver(key: key, storage: storage))
    }
    
    public init(_ key: Key, storage: Storage, observer: StorageKeyObserver<Storage, Key>) {
        self.key = key
        self.storage = storage
        
        _observer = StateObject(wrappedValue: observer)
    }
    
    // MARK: Property Wrapper Implementation
    
    public var projectedValue: Binding<Key.Value> {
        Binding {
            wrappedValue
        } set: {
            wrappedValue = $0
        }
    }
    
    public var wrappedValue: Key.Value {
        get {
            storage.get(key)
        }
        nonmutating set {
            storage.set(key, to: newValue)
        }
    }
}
