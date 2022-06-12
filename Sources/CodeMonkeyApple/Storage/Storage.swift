//
//  Storage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

import Foundation

public protocol Storage {
    // MARK: Getting Values
    
    func get<Value>(_ key: StorageKey<Value>) -> Value
    func get<Value>(_ key: DebugStorageKey<Value>) -> Value
    
    // MARK: Setting Values
    
    func set<Value>(_ key: StorageKey<Value>, to value: Value)
    func set<Value>(_ key: DebugStorageKey<Value>, to value: Value)
    
    // MARK: Removing Values
    
    func remove<Value>(_ key: StorageKey<Value>)
    func remove<Value>(_ key: DebugStorageKey<Value>)
}

#if DEBUG
// MARK: - Preview

extension Storage {
    // MARK: Public Static Interface
    
    public static var preview: Storage {
        InMemoryStorage.preview
    }
}
#endif
