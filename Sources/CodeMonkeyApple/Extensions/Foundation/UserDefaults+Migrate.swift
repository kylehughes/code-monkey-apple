//
//  UserDefaults+Migrate.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/9/22.
//

import Foundation
import os.log

private let logger = Logger(subsystem: "es.kylehugh.code-monkey-apple", category: "user-defaults")

extension UserDefaults {
    // MARK: Public Instance Interface
    
    public func migrate(to other: UserDefaults) {
        logger.info("Attempting to migrate to other store…")
        
        guard not(other.get(.wasMigratedTo)) else {
            logger.info("Skipping migration, other store was already migrated to")
            
            return
        }
        
        logger.info("Commencing one-time migration…")
        
        for (key, value) in dictionaryRepresentation() {
            other.set(value, forKey: key)
        }
        
        other.set(.wasMigratedTo, to: true)
        
        logger.info("Finished migrating to other store")
    }
}

// MARK: - Boolean Storage Keys

extension StorageKeyProtocol where Self == StorageKey<Bool> {
    // MARK: Public Static Interface
    
    public static var wasMigratedTo: Self {
        StorageKey(
            id: "WasMigratedTo",
            defaultValue: false
        )
    }
}
