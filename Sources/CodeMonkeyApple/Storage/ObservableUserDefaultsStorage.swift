//
//  UserDefaultsStorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/21/22.
//

import Foundation

final class ObservableUserDefaultsStorage<Key>: ObservableStorage<Key> where Key: StorageKeyProtocol {
    private let userDefaults: UserDefaults
    
    private var context: Int
    
    // MARK: Internal Initialization
    
    init(storage: UserDefaults, key: Key) {
        context = 0
        userDefaults = storage
        
        super.init(key: key)
        
        for keyID in key.compositeIDs {
            storage.addObserver(self, forKeyPath: keyID, context: &context)
        }
    }
    
    // MARK: Deinitialization
    
    deinit {
        for keyID in key.compositeIDs {
            userDefaults.removeObserver(self, forKeyPath: keyID, context: &context)
        }
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
