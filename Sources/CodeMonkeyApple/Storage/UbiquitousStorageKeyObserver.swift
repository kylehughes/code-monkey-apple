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
                guard
                    let changedKeyIDs = notification.userInfo?[userInfoKey] as? [String],
                    changedKeyIDs.contains(key.id)
                else {
                    return
                }
                
                objectWillChange.send()
            }
        }
    }
}
