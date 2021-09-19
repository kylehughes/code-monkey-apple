//
//  UserDefaults+UserDefaultsKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/28/21.
//

import Foundation

extension UserDefaults {
    // MARK: Public Instance Interface
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<[Any]>) -> [Any] {
        array(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<[Any]?>) -> [Any]? {
        array(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Bool>) -> Bool {
        bool(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Bool>) -> Bool? {
        bool(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Data>) -> Data {
        data(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Data?>) -> Data? {
        data(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Double>) -> Double {
        double(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Float>) -> Float {
        float(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Int>) -> Int {
        integer(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Any>) -> Any {
        object(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<Any?>) -> Any? {
        object(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<String>) -> String {
        string(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<String?>) -> String? {
        string(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<[String]>) -> [String] {
        stringArray(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<[String]?>) -> [String]? {
        stringArray(forKey: key.key)
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<URL>) -> URL {
        url(forKey: key.key) ?? key.defaultValue
    }
    
    @inlinable
    public func getValue(for key: UserDefaultsKey<URL?>) -> URL? {
        url(forKey: key.key)
    }
    
    @inlinable
    public func getValue<Value>(
        for key: UserDefaultsKey<Value>
    ) -> Value where Value: RawRepresentable, Value.RawValue == String {
        guard let rawString = string(forKey: key.key), let value = Value(rawValue: rawString) else {
            return key.defaultValue
        }

        return value
    }
    
    @inlinable
    public func register(_ builder: (UserDefaultsRegistrationBuilder) -> UserDefaultsRegistrationBuilder) {
        register(defaults: builder(.init()).build())
    }
    
    @inlinable
    public func setValue(_ value: Any, for key: UserDefaultsKey<Any>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: Any, for key: UserDefaultsKey<Any?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: Any?, for key: UserDefaultsKey<Any?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: Bool, for key: UserDefaultsKey<Bool>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: Double, for key: UserDefaultsKey<Double>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: Int, for key: UserDefaultsKey<Int>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: String, for key: UserDefaultsKey<String>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: String, for key: UserDefaultsKey<String?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: String?, for key: UserDefaultsKey<String?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: URL, for key: UserDefaultsKey<URL>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: URL, for key: UserDefaultsKey<URL?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue(_ value: URL?, for key: UserDefaultsKey<URL?>) {
        set(value, forKey: key.key)
    }
    
    @inlinable
    public func setValue<Value>(
        _ value: Value,
        for key: UserDefaultsKey<Value>
    ) where Value: RawRepresentable, Value.RawValue == String {
        set(value.rawValue, forKey: key.key)
    }
}
