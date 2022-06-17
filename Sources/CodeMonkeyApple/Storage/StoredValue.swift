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
    private let key: Key
    
    @StateObject private var storage: ObservableStorage<Storage, Key>
    
    // MARK: Public Initialization
    
    public init(_ key: Key, storage: Storage = .default) where Storage == NSUbiquitousKeyValueStore {
        self.init(key, storage: ObservableUbiquitousStorage(storage: storage, key: key))
    }
    
    public init(_ key: Key, storage: Storage = .standard) where Storage == UserDefaults {
        self.init(key, storage: ObservableUserDefaultsStorage(key: key, storage: storage))
    }
    
    public init(_ key: Key, storage: ObservableStorage<Storage, Key>) {
        self.key = key
        
        _storage = StateObject(wrappedValue: storage)
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
            storage.value
        }
        nonmutating set {
            storage.value = newValue
        }
    }
}
