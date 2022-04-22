//
//  StoredDebugValue.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/21/22.
//

import Combine
import Foundation
import SwiftUI

@propertyWrapper
public struct StoredDebugValue<Value>: DynamicProperty where Value: Storable {
    @StateObject private var observer: UserDefaultsStorageKeyObserver<DebugStorageKey<Value>>
    
    private let key: DebugStorageKey<Value>
    private let storage: UserDefaults
    
    // MARK: Public Initialization
    
    public init(_ key: DebugStorageKey<Value>, storage: UserDefaults = .standard) {
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
