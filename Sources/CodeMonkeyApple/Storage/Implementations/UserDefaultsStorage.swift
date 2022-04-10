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
    
    // MARK: Getting Debug Values
    
    @inlinable
    public func get(_ key: DebugStorageKey<Bool>) -> Bool {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Bool?>) -> Bool? {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Data>) -> Data {
        #if DEBUG
        .decode(for: key, from: data(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Data?>) -> Data? {
        #if DEBUG
        .decode(for: key, from: data(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Date>) -> Date {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Date?>) -> Date? {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    public func get(_ key: DebugStorageKey<Double>) -> Double {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Double?>) -> Double? {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Float>) -> Float {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Float?>) -> Float? {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Int>) -> Int {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<Int?>) -> Int? {
        #if DEBUG
        .decode(for: key, from: object(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<String>) -> String {
        #if DEBUG
        .decode(for: key, from: string(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<String?>) -> String? {
        #if DEBUG
        .decode(for: key, from: string(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<[String]>) -> [String] {
        #if DEBUG
        .decode(for: key, from: stringArray(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<[String]?>) -> [String]? {
        #if DEBUG
        .decode(for: key, from: stringArray(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<URL>) -> URL {
        #if DEBUG
        .decode(for: key, from: url(forKey: key.id))
        #else
        key.defaultValue
        #endif
    }
    
    @inlinable
    public func get(_ key: DebugStorageKey<URL?>) -> URL? {
        #if DEBUG
        .decode(for: key, from: url(forKey: key.id))
        #else
        key.defaultValue
        #endif
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
    
    // MARK: Setting Debug Values
    
    @inlinable
    public func set(_ key: DebugStorageKey<Bool>, to value: Bool) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Bool?>, to value: Bool?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Data>, to value: Data) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Data?>, to value: Data?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Date>, to value: Date) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Date?>, to value: Date?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Double>, to value: Double) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Double?>, to value: Double?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Float>, to value: Float) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Float?>, to value: Float?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Int>, to value: Int) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<Int?>, to value: Int?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<String>, to value: String) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<String?>, to value: String?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<[String]>, to value: [String]) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<[String]?>, to value: [String]?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<URL>, to value: URL) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    @inlinable
    public func set(_ key: DebugStorageKey<URL?>, to value: URL?) {
        #if DEBUG
        set(value.encodeForStorage(), forKey: key.id)
        #else
        // NO-OP
        #endif
    }
    
    // MARK: Removing Values

    @inlinable
    public func remove<Value>(_ key: StorageKey<Value>) {
        removeObject(forKey: key.id)
    }
    
    // MARK: Removing Debug Values

    @inlinable
    public func remove<Value>(_ key: DebugStorageKey<Value>) {
        #if DEBUG
        removeObject(forKey: key.id)
        #else
        // NO-OP
        #endif
    }
}
