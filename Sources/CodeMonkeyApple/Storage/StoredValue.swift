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
    
    @StateObject private var observer: StorageKeyObserver<Key>
    
    // MARK: Public Initialization
    
    public init(_ key: Key, storage: Storage) {
        self.key = key
        
        _observer = StateObject(wrappedValue: StorageKeyObserver(storage: storage, key: key))
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
            observer.value
        }
        nonmutating set {
            observer.value = newValue
        }
    }
}
