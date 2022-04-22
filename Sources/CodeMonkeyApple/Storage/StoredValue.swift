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
    @StateObject private var observer: UserDefaultsStorageKeyObserver<StorageKey<Value>>
    
    private let key: StorageKey<Value>
    private let storage: UserDefaults
    
    // MARK: Public Initialization
    
    public init(_ key: StorageKey<Value>, storage: UserDefaults = .standard) {
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
            storage.get(key)
        }
        nonmutating set {
            storage.set(key, to: newValue)
        }
    }
}
