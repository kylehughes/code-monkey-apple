//
//  Storage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

import Foundation

public protocol Storage {
    // MARK: Getting Values
    
    func get<Value>(_ key: StorageKey<Value>) async -> Value
    func get<Value>(_ key: DebugStorageKey<Value>) async -> Value
    
    // MARK: Setting Values
    
    func set<Value>(_ key: StorageKey<Value>, to value: Value) async
    func set<Value>(_ key: DebugStorageKey<Value>, to value: Value) async
    
    // MARK: Removing Values
    
    func remove<Value>(_ key: StorageKey<Value>) async
    func remove<Value>(_ key: DebugStorageKey<Value>) async
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
