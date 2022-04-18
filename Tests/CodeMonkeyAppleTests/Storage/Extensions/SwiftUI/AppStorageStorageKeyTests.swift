//
//  AppStorageTests+StorageKey.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/18/22.
//

import Foundation
import SwiftUI
import XCTest

@testable import CodeMonkeyApple

final class AppStorageStorageKeyTests: XCTestCase {
    private let storage = UserDefaults.standard
    
    // MARK: XCTestCase Implementation
    
    override func tearDown() async throws {
        storage.dictionaryRepresentation().keys.forEach(storage.removeObject)
    }
}

// MARK: - Built-In Type Tests

extension AppStorageStorageKeyTests {
    // MARK: Tests
    
    func test_bool() {
        typealias Value = Bool
        let defaultValue: Value = false
        let expectedNewValue: Value = true
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_bool_optional_existingValue() {
        typealias Value = Bool?
        let defaultValue: Value = false
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_bool_optional_noValue() {
        typealias Value = Bool?
        let defaultValue: Value = nil
        let expectedNewValue: Value = true
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_data() {
        typealias Value = Data
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_data_optional_existingValue() {
        typealias Value = Data?
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_data_optional_noValue() {
        typealias Value = Data?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_double() {
        typealias Value = Double
        let defaultValue: Value = .random(in: 0 ... .greatestFiniteMagnitude)
        let expectedNewValue: Value = .random(in: 0 ... .greatestFiniteMagnitude)
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_double_optional_existingValue() {
        typealias Value = Double?
        let defaultValue: Value = .random(in: 0 ... .greatestFiniteMagnitude)
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_double_optional_noValue() {
        typealias Value = Double?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0 ... .greatestFiniteMagnitude)
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_int() {
        typealias Value = Int
        let defaultValue: Value = .random(in: 0 ... .max)
        let expectedNewValue: Value = .random(in: 0 ... .max)
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_int_optional_existingValue() {
        typealias Value = Int?
        let defaultValue: Value = .random(in: 0 ... .max)
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_int_optional_noValue() {
        typealias Value = Int?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0 ... .max)
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_string() {
        typealias Value = String
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = UUID().uuidString
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_string_optional_existingValue() {
        typealias Value = String?
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_string_optional_noValue() {
        typealias Value = String?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_url() {
        typealias Value = URL
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_url_optional_existingValue() {
        typealias Value = URL?
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = nil
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        storage.set(key, to: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
    
    func test_url_optional_noValue() {
        typealias Value = URL?
        let defaultValue: Value = nil
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        
        let propertyWrapper = AppStorage(key, storage: storage)
        XCTAssertEqual(propertyWrapper.wrappedValue, defaultValue)
        propertyWrapper.wrappedValue = expectedNewValue
        XCTAssertEqual(propertyWrapper.wrappedValue, expectedNewValue)
    }
}
