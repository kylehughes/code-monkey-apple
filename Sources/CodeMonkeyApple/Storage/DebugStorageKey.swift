//
//  DebugStorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/9/22.
//

public struct DebugStorageKey<Value>: Identifiable, StorageKeyProtocol where Value: Storable {
    public let defaultValue: Value
    public let id: String
    
    // MARK: Public Initialization
    
    public init(id: String, defaultValue: Value) {
        self.id = id
        self.defaultValue = defaultValue
    }
}
