//
//  InMemoryStorage.swift
//  Super Headache
//
//  Created by Kyle Hughes on 3/23/21.
//

import Foundation

public final class InMemoryStorage {
    private var storage: [String: Any]
    
    // MARK: Public Initialization
    
    public init() {
        storage = [:]
    }
    
    // MARK: Private Instance Interface
    
    private subscript(key: String) -> Any? {
        get {
            storage[key]
        }
        set {
            storage[key] = newValue
        }
    }
}

// MARK: - Storage Extension

extension InMemoryStorage: Storage {
    // MARK: Getting Values
    
    public func get(_ key: StorageKey<Bool>) async -> Bool {
        self[key.id] as? Bool ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Bool?>) async -> Bool? {
        self[key.id] as? Bool? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Data>) async -> Data {
        self[key.id] as? Data ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Data?>) async -> Data? {
        self[key.id] as? Data? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Date>) async -> Date {
        self[key.id] as? Date ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Date?>) async -> Date? {
        self[key.id] as? Date? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Double>) async -> Double {
        self[key.id] as? Double ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Double?>) async -> Double? {
        self[key.id] as? Double? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Float>) async -> Float {
        self[key.id] as? Float ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Float?>) async -> Float? {
        self[key.id] as? Float? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Int>) async -> Int {
        self[key.id] as? Int ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<Int?>) async -> Int? {
        self[key.id] as? Int? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<String>) async -> String {
        self[key.id] as? String ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<String?>) async -> String? {
        self[key.id] as? String? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<[String]>) async -> [String] {
        self[key.id] as? [String] ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<[String]?>) async -> [String]? {
        self[key.id] as? [String]? ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<URL>) async -> URL {
        self[key.id] as? URL ?? key.defaultValue
    }
    
    public func get(_ key: StorageKey<URL?>) async -> URL? {
        self[key.id] as? URL? ?? key.defaultValue
    }
    
    // MARK: Setting Values

    public func set(_ key: StorageKey<Bool>, to value: Bool) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Bool?>, to value: Bool?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Data>, to value: Data) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Data?>, to value: Data?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Date>, to value: Date) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Date?>, to value: Date?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Double>, to value: Double) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Double?>, to value: Double?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Float>, to value: Float) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Float?>, to value: Float?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Int>, to value: Int) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<Int?>, to value: Int?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<String>, to value: String) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<String?>, to value: String?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<[String]>, to value: [String]) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<[String]?>, to value: [String]?) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<URL>, to value: URL) async {
        self[key.id] = value
    }
    
    public func set(_ key: StorageKey<URL?>, to value: URL?) async {
        self[key.id] = value
    }
    
    // MARK: Removing Values
    
    public func remove<Value>(_ key: StorageKey<Value>) async {
        storage.removeValue(forKey: key.id)
    }
}

#if DEBUG
// MARK: - Previews

extension InMemoryStorage {
    // MARK: Public Static Interface
    
    public static let preview = InMemoryStorage()
}
#endif
