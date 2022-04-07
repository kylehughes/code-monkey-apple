//
//  UserDefaultsStorage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

import Foundation

extension UserDefaults: Storage {
    // MARK: Getting Values

    @inlinable
    public func get(_ key: StorageKey<Bool>) -> Bool {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Bool?>) -> Bool? {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Data>) -> Data {
        .decode(for: key, from: data(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Data?>) -> Data? {
        .decode(for: key, from: data(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Date>) -> Date {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Date?>) -> Date? {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    public func get(_ key: StorageKey<Double>) -> Double {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Double?>) -> Double? {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Float>) -> Float {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Float?>) -> Float? {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Int>) -> Int {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<Int?>) -> Int? {
        .decode(for: key, from: object(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<String>) -> String {
        .decode(for: key, from: string(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<String?>) -> String? {
        .decode(for: key, from: string(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<[String]>) -> [String] {
        .decode(for: key, from: stringArray(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<[String]?>) -> [String]? {
        .decode(for: key, from: stringArray(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<URL>) -> URL {
        .decode(for: key, from: url(forKey: key.id))
    }
    
    @inlinable
    public func get(_ key: StorageKey<URL?>) -> URL? {
        .decode(for: key, from: url(forKey: key.id))
    }
    
    // MARK: Setting Values
    
    @inlinable
    public func set(_ key: StorageKey<Bool>, to value: Bool) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Bool?>, to value: Bool?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Data>, to value: Data) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Data?>, to value: Data?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Date>, to value: Date) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Date?>, to value: Date?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Double>, to value: Double) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Double?>, to value: Double?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Float>, to value: Float) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Float?>, to value: Float?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Int>, to value: Int) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<Int?>, to value: Int?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<String>, to value: String) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<String?>, to value: String?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<[String]>, to value: [String]) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<[String]?>, to value: [String]?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<URL>, to value: URL) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    @inlinable
    public func set(_ key: StorageKey<URL?>, to value: URL?) {
        set(value.encodeForStorage(), forKey: key.id)
    }
    
    // MARK: Removing Values

    @inlinable
    public func remove<Value>(_ key: StorageKey<Value>) {
        removeObject(forKey: key.id)
    }
}
