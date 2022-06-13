//
//  UserDefaultsStorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/21/22.
//

import Foundation

final class UserDefaultsStorageKeyObserver<Key>: StorageKeyObserver<UserDefaults, Key> where Key: StorageKeyProtocol {
    private var context: Int
    
    // MARK: Internal Initialization
    
    init(key: Key, storage: UserDefaults) {
        context = 0
        
        super.init(storage: storage, key: key)
        
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
        Task {
            await MainActor.run {
                objectWillChange.send()
            }
        }
    }
}
