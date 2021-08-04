//
//  UserDefaults+UserDefaultsKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/28/21.
//

import Foundation

extension UserDefaults {
    // MARK: Public Instance Interface
    
    public func getValue(for key: UserDefaultsKey<Bool>) -> Bool {
        bool(forKey: key.key)
    }
    
    public func getValue<Value>(
        for key: UserDefaultsKey<Value>
    ) -> Value where Value: RawRepresentable, Value.RawValue == String {
        guard let rawString = string(forKey: key.key), let value = Value(rawValue: rawString) else {
            return key.defaultValue
        }

        return value
    }
    
    public func register(_ builder: (UserDefaultsRegistrationBuilder) -> UserDefaultsRegistrationBuilder) {
        register(defaults: builder(.init()).build())
    }
    
    public func setValue<Value>(
        _ value: Value,
        for key: UserDefaultsKey<Value>
    ) where Value: RawRepresentable, Value.RawValue == String {
        set(value.rawValue, forKey: key.key)
    }
}
