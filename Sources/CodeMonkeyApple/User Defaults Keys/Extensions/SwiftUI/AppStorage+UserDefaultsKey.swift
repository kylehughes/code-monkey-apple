//
//  AppStorage+UserDefaultsKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/27/21.
//

import SwiftUI

extension AppStorage {
    // MARK: Public Initialization
    
    public init(_ key: UserDefaultsKey<Bool>) where Value == Bool {
        self.init(wrappedValue: key.defaultValue, key.key)
    }
    
    public init(_ key: UserDefaultsKey<Value>) where Value: RawRepresentable, Value.RawValue == String {
        self.init(wrappedValue: key.defaultValue, key.key)
    }
}
