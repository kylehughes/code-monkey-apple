//
//  AppStorage+StorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/7/22.
//

import SwiftUI

extension AppStorage {
    // MARK: Public Initialization
    
    public init(_ key: StorageKey<Value>) where Value == Bool {
        self.init(wrappedValue: key.defaultValue.encodeForStorage(), key.id)
    }
}
