//
//  UbiquitousStorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

private let userInfoKey = AnyHashable(NSUbiquitousKeyValueStoreChangedKeysKey)

final class UbiquitousStorageKeyObserver<Key>: StorageKeyObserver<NSUbiquitousKeyValueStore, Key>
where
    Key: StorageKeyProtocol
{
    // MARK: Internal Initialization
    
    override init(storage: NSUbiquitousKeyValueStore, key: Key) {
        super.init(storage: storage, key: key)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didChangeExternally),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: storage
        )
    }
    
    // MARK: NSObject Implementation
    
    @objc private func didChangeExternally(_ notification: Notification) {
        Task {
            await MainActor.run {
                guard let changedKeyIDs = notification.userInfo?[userInfoKey] as? [String] else {
                    return
                }
                
                let changedKeyIDsSet = Set(changedKeyIDs)
                
                guard not(changedKeyIDsSet.union(key.compositeIDs).isEmpty) else {
                    return
                }
                
                objectWillChange.send()
            }
        }
    }
}
