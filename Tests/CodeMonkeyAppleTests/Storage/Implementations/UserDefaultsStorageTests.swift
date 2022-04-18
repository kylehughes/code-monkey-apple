//
//  UserDefaultsStorageTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 3/28/22.
//

import XCTest

@testable import CodeMonkeyApple

final class UserDefaultsStorageTests: XCTestCase {
    private let storage = UserDefaults.standard
    
    // MARK: XCTestCase Implementation
    
    override func tearDown() async throws {
        storage.dictionaryRepresentation().keys.forEach(storage.removeObject)
    }
}

// MARK: - Getting Values Tests

extension UserDefaultsStorageTests {
    // MARK: Tests
    
    func test_get_bool() async {
        typealias Value = Bool
        let defaultValue: Value = true
        let expectedNewValue: Value = false
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_bool_optional() async {
        typealias Value = Bool?
        let defaultValue: Value = nil
        let expectedNewValue: Value = true
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_data() async {
        typealias Value = Data
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_data_optional() async {
        typealias Value = Data?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_date() async {
        typealias Value = Date
        let defaultValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_date_optional() async {
        typealias Value = Date?
        let defaultValue: Value = nil
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_double() async {
        typealias Value = Double
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_double_optional() async {
        typealias Value = Double?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_float() async {
        typealias Value = Float
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_float_optional() async {
        typealias Value = Float?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_int() async {
        typealias Value = Int
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_int_optional() async {
        typealias Value = Int?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_string() async {
        typealias Value = String
        let defaultValue: Value = "DEFAULT"
        let expectedNewValue: Value = "NEW"
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_string_optional() async {
        typealias Value = String?
        let defaultValue: Value = nil
        let expectedNewValue: Value = "NEW"
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_stringArray() async {
        typealias Value = [String]
        let defaultValue: Value = ["DEFAULT1", "DEFAULT2"]
        let expectedNewValue: Value = ["NEW1", "NEW2"]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_stringArray_optional() async {
        typealias Value = [String]?
        let defaultValue: Value = nil
        let expectedNewValue: Value = ["NEW1", "NEW2"]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_url() async {
        typealias Value = URL
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_url_optional() async {
        typealias Value = URL?
        let defaultValue: Value = nil
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
}

// MARK: - Setting Value Tests

extension UserDefaultsStorageTests {
    // MARK: Boolean Tests
    
    func test_set_bool() async {
        typealias Value = Bool
        let defaultValue: Value = true
        let expectedNewValue: Value = false
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_bool_optional_defaultNil() async {
        typealias Value = Bool?
        let defaultValue: Value = nil
        let expectedNewValue: Value = false
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_bool_optional_defaultTrue() async {
        typealias Value = Bool?
        let defaultValue: Value = true
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Data Tests
    
    func test_set_data() async {
        typealias Value = Data
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_data_optional_defaultNil() async {
        typealias Value = Data?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_data_optional_defaultTrue() async {
        typealias Value = Data?
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Date Tests
    
    func test_set_date() async {
        typealias Value = Date
        let defaultValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Date(timeIntervalSince1970: storage.object(forKey: key.id) as? TimeInterval ?? -1)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_date_optional_defaultNil() async {
        typealias Value = Date?
        let defaultValue: Value = nil
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Date(timeIntervalSince1970: storage.object(forKey: key.id) as? TimeInterval ?? -1)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_date_optional_defaultTrue() async {
        typealias Value = Date?
        let defaultValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Double Tests
    
    func test_set_double() async {
        typealias Value = Double
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_double_optional_defaultNil() async {
        typealias Value = Double?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_double_optional_defaultTrue() async {
        typealias Value = Double?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Float Tests
    
    func test_set_float() async {
        typealias Value = Float
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_float_optional_defaultNil() async {
        typealias Value = Float?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_float_optional_defaultTrue() async {
        typealias Value = Float?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Integer Tests
    
    func test_set_int() async {
        typealias Value = Int
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_int_optional_defaultNil() async {
        typealias Value = Int?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_int_optional_defaultTrue() async {
        typealias Value = Int?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: String Tests
    
    func test_set_string() async {
        typealias Value = String
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = UUID().uuidString
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_string_optional_defaultNil() async {
        typealias Value = String?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_string_optional_defaultTrue() async {
        typealias Value = String?
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: String Array Tests
    
    func test_set_stringArray() async {
        typealias Value = [String]
        let defaultValue: Value = [UUID().uuidString, UUID().uuidString]
        let expectedNewValue: Value = [UUID().uuidString, UUID().uuidString]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_stringArray_optional_defaultNil() async {
        typealias Value = [String]?
        let defaultValue: Value = nil
        let expectedNewValue: Value = [UUID().uuidString, UUID().uuidString]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_stringArray_optional_defaultTrue() async {
        typealias Value = [String]?
        let defaultValue: Value = [UUID().uuidString, UUID().uuidString]
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.object(forKey: key.id) as? Value
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: URL Tests
    
    func test_set_url() async {
        typealias Value = URL
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.url(forKey: key.id)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_url_optional_defaultNil() async {
        typealias Value = URL?
        let defaultValue: Value = nil
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.url(forKey: key.id)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_url_optional_defaultTrue() async {
        typealias Value = URL?
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = storage.url(forKey: key.id)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
}
