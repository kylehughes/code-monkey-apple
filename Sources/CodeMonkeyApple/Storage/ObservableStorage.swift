//
//  StorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public class ObservableStorage<Key>: NSObject, ObservableObject where Key: StorageKeyProtocol {
    public let key: Key
    
    // MARK: Public Initialization
    
    public init(key: Key) {
        self.key = key
    }
    
    // MARK: Public Instance Interface
    
    public var storage: any Storage {
        fatalError("Should be implemented by subclass.")
    }
    
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
