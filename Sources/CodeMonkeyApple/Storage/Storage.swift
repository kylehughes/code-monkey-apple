//
//  Storage.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

import Foundation

public protocol Storage {
    // MARK: Getting Values
    
    func get(_ key: StorageKey<Bool>) async -> Bool
    func get(_ key: StorageKey<Bool?>) async -> Bool?
    func get(_ key: StorageKey<Data>) async -> Data
    func get(_ key: StorageKey<Data?>) async -> Data?
    func get(_ key: StorageKey<Date>) async -> Date
    func get(_ key: StorageKey<Date?>) async -> Date?
    func get(_ key: StorageKey<Double>) async -> Double
    func get(_ key: StorageKey<Double?>) async -> Double?
    func get(_ key: StorageKey<Float>) async -> Float
    func get(_ key: StorageKey<Float?>) async -> Float?
    func get(_ key: StorageKey<Int>) async -> Int
    func get(_ key: StorageKey<Int?>) async -> Int?
    func get(_ key: StorageKey<String>) async -> String
    func get(_ key: StorageKey<String?>) async -> String?
    func get(_ key: StorageKey<[String]>) async -> [String]
    func get(_ key: StorageKey<[String]?>) async -> [String]?
    func get(_ key: StorageKey<URL>) async -> URL
    func get(_ key: StorageKey<URL?>) async -> URL?
    
    // MARK: Setting Values

    func set(_ key: StorageKey<Bool>, to value: Bool) async
    func set(_ key: StorageKey<Bool?>, to value: Bool?) async
    func set(_ key: StorageKey<Data>, to value: Data) async
    func set(_ key: StorageKey<Data?>, to value: Data?) async
    func set(_ key: StorageKey<Date>, to value: Date) async
    func set(_ key: StorageKey<Date?>, to value: Date?) async
    func set(_ key: StorageKey<Double>, to value: Double) async
    func set(_ key: StorageKey<Double?>, to value: Double?) async
    func set(_ key: StorageKey<Float>, to value: Float) async
    func set(_ key: StorageKey<Float?>, to value: Float?) async
    func set(_ key: StorageKey<Int>, to value: Int) async
    func set(_ key: StorageKey<Int?>, to value: Int?) async
    func set(_ key: StorageKey<String>, to value: String) async
    func set(_ key: StorageKey<String?>, to value: String?) async
    func set(_ key: StorageKey<[String]>, to value: [String]) async
    func set(_ key: StorageKey<[String]?>, to value: [String]?) async
    func set(_ key: StorageKey<URL>, to value: URL) async
    func set(_ key: StorageKey<URL?>, to value: URL?) async
    
    // MARK: Removing Values
    
    func remove<Value>(_ key: StorageKey<Value>) async
}

#if DEBUG
// MARK: - Preview

extension Storage {
    // MARK: Public Static Interface
    
    public static var preview: Storage {
        InMemoryStorage.preview
    }
}
#endif
