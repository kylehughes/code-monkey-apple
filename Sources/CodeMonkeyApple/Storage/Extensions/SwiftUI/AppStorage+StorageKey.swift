//
//  AppStorage+StorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/7/22.
//

import SwiftUI

extension AppStorage {
    // MARK: Public Initialization
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == Bool {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == Data {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == Double {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == Int {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == String {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value == URL {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value: RawRepresentable, Value.RawValue == Int {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
    
    @inlinable
    public init(_ key: StorageKey<Value>) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: key.defaultValue, key.id)
    }
}
