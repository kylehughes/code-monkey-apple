//
//  StorageKey+Debug.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/20/22.
//

// MARK: - Boolean Debug Storage Keys

extension StorageKeyProtocol where Self == DebugStorageKey<Bool> {
    // MARK: Public Static Interface
    
    public static var enableAppStoreRating: Self {
        Self(
            id: "EnableAppStoreRating",
            defaultValue: true
        )
    }
}
