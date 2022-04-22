//
//  UserDefaultsStorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/21/22.
//

import Foundation

final class UserDefaultsStorageKeyObserver<Key>: NSObject, ObservableObject where Key: StorageKeyProtocol {
    private let key: Key
    private let storage: UserDefaults
    
    private var context: Int
    
    // MARK: Internal Initialization
    
    init(key: Key, storage: UserDefaults) {
        self.key = key
        self.storage = storage
        
        context = 0
        
        super.init()
        
        storage.addObserver(self, forKeyPath: key.id, context: &context)
    }
    
    // MARK: Deinitialization
    
    deinit {
        storage.removeObserver(self, forKeyPath: key.id, context: &context)
    }
    
    // MARK: NSObject Implementation
    
    public override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        objectWillChange.send()
    }
}
