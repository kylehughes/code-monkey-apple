//
//  UserDefaultsRegistrationBuilder.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/27/21.
//

public struct UserDefaultsRegistrationBuilder {
    private var registrations: [String: Any]
    
    // MARK: Public Initialization
    
    public init() {
        registrations = [:]
    }
    
    // MARK: Public Instance Interface
    
    public func adding<Value>(_ key: UserDefaultsKey<Value>) -> UserDefaultsRegistrationBuilder {
        var copy = self
        copy.registrations[key.key] = key.defaultValue
        
        return copy
    }
    
    public func adding<Value>(
        _ key: UserDefaultsKey<Value>
    ) -> UserDefaultsRegistrationBuilder
    where
        Value: Codable & RawRepresentable
    {
        var copy = self
        copy.registrations[key.key] = key.defaultValue.rawValue
        
        return copy
    }
    
    public func build() -> [String: Any] {
        registrations
    }
}
