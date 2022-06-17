//
//  StorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public class ObservableStorage<Storage, Key>: NSObject, ObservableObject
where
    Storage: CodeMonkeyApple.Storage,
    Key: StorageKeyProtocol
{
    public let key: Key
    public let storage: Storage
    
    // MARK: Public Initialization
    
    public init(storage: Storage, key: Key) {
        self.storage = storage
        self.key = key
    }
    
    // MARK: Internal Instance Interface
    
    public var value: Key.Value {
        get {
            storage.get(key)
        }
        set {
            objectWillChange.send()
            
            storage.set(key, to: newValue)
        }
    }
}
