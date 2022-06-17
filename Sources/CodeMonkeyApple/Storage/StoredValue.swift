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
public struct StoredValue<Key>: DynamicProperty where Key: StorageKeyProtocol {
    private let key: Key
    
    @StateObject private var storage: ObservableStorage<Key>
    
    // MARK: Public Initialization
    
    public init(_ key: Key, storage: NSUbiquitousKeyValueStore = .default) {
        self.init(key, storage: ObservableUbiquitousStorage(storage: storage, key: key))
    }
    
    public init(_ key: Key, storage: UserDefaults = .standard) {
        self.init(key, storage: ObservableUserDefaultsStorage(storage: storage, key: key))
    }
    
    public init(_ key: Key, storage: ObservableStorage<Key>) {
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
