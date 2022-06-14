//
//  CompositeStorageKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/12/22.
//

import Foundation

// TODO: Replace Tuple(2|3) usage with variadic generics when available.

public struct CompositeStorageKey<Value, ComposedKey>
where
    Value: CompositeStorable,
    ComposedKey: StorageKeyProtocol,
    Value.Components == ComposedKey.Value
{
    @StorageKeyBuilder private let compose: () -> ComposedKey
    
    // MARK: Public Initialization
    
    public init(@StorageKeyBuilder compose: @escaping () -> ComposedKey) {
        self.compose = compose
    }
}

// MARK: - StorageKeyProtocol Extension

extension CompositeStorageKey: StorageKeyProtocol {
    // MARK: Public Instance Interface
    
    public var compositeIDs: Set<String> {
        compose().compositeIDs
    }
    
    public var defaultValue: Value {
        Value.compose(from: compose().defaultValue)
    }
    
    public func get(from ubiquitousStore: NSUbiquitousKeyValueStore) -> Value {
        Value.compose(from: compose().get(from: ubiquitousStore))
    }
    
    public func get(from userDefaults: UserDefaults) -> Value {
        Value.compose(from: compose().get(from: userDefaults))
    }
    
    public func remove(from ubiquitousStore: NSUbiquitousKeyValueStore) {
        compose().remove(from: ubiquitousStore)
    }
    
    public func remove(from userDefaults: UserDefaults) {
        compose().remove(from: userDefaults)
    }
    
    public func set(to newValue: Value, in ubiquitousStore: NSUbiquitousKeyValueStore) {
        compose().set(to: newValue.encodeForStorage(), in: ubiquitousStore)
    }
    
    public func set(to newValue: Value, in userDefaults: UserDefaults) {
        compose().set(to: newValue.encodeForStorage(), in: userDefaults)
    }
}

// MARK: - Example

//struct Example: CompositeStorable {
//    typealias Components = Tuple3<String, Int, Date>
//
//    let string: String
//    let number: Int
//    let date: Date
//
//    static func compose(from components: Components) -> Example {
//        Example(string: components.e1, number: components.e2, date: components.e3)
//    }
//
//    func encodeForStorage() -> Components {
//        Components(string, number, date)
//    }
//}
//
//extension StorageKeyProtocol
//where
//    Self == CompositeStorageKey<Example, Tuple3<StorageKey<String>, StorageKey<Int>, StorageKey<Date>>>
//{
//    static var example: CompositeStorageKey<Example, Tuple3<StorageKey<String>, StorageKey<Int>, StorageKey<Date>>> {
//        CompositeStorageKey(id: "example") {
//            StorageKey.string
//            StorageKey.number
//            StorageKey.date
//        }
//    }
//}
//
//extension StorageKey where Value == Date {
//    static var date: StorageKey<Value> {
//        StorageKey(id: "Date", defaultValue: .now)
//    }
//}
//
//extension StorageKey where Value == Int {
//    static var number: StorageKey<Value> {
//        StorageKey(id: "Number", defaultValue: 2)
//    }
//}
//
//extension StorageKey where Value == String {
//    static var string: StorageKey<Value> {
//        StorageKey(id: "String", defaultValue: "lol")
//    }
//}
