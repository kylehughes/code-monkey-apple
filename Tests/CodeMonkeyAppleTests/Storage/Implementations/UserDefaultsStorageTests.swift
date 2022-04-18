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

// MARK: - Complex Getting Value Tests

extension UserDefaultsStorageTests {
    // MARK: RawRepresentable Tests
    
    func test_get_rawRepresentable() {
        typealias Value = TestRawRepresentableStorable
        let defaultValue: Value = .caseOne
        let expectedNewValue: Value = .caseTwo
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_rawRepresentable_optional() {
        typealias Value = TestRawRepresentableStorable?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .caseTwo
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    // MARK: Codable Tests
    
    func test_get_codable() {
        typealias Value = TestCodableStorable
        let defaultValue: Value = .random
        let expectedNewValue: Value = .random
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(expectedNewValue.encodeForStorage(), forKey: key.id)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_get_codable_optional() {
        typealias Value = TestCodableStorable?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random
        
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
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_bool_optional_default() async {
        typealias Value = Bool?
        let defaultValue: Value = nil
        let expectedNewValue: Value = false
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_bool_optional_set() async {
        typealias Value = Bool?
        let defaultValue: Value = true
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Data Tests
    
    func test_set_data() async {
        typealias Value = Data
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_data_optional_default() async {
        typealias Value = Data?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString.data(using: .utf8)!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_data_optional_set() async {
        typealias Value = Data?
        let defaultValue: Value = UUID().uuidString.data(using: .utf8)!
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Date Tests
    
    func test_set_date() async {
        typealias Value = Date
        let defaultValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_date_optional_default() async {
        typealias Value = Date?
        let defaultValue: Value = nil
        let expectedNewValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_date_optional_set() async {
        typealias Value = Date?
        let defaultValue: Value = Date(timeIntervalSince1970: .random(in: 0 ... 100_000))
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Double Tests
    
    func test_set_double() async {
        typealias Value = Double
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_double_optional_default() async {
        typealias Value = Double?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_double_optional_set() async {
        typealias Value = Double?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Float Tests
    
    func test_set_float() async {
        typealias Value = Float
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_float_optional_default() async {
        typealias Value = Float?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_float_optional_set() async {
        typealias Value = Float?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Integer Tests
    
    func test_set_int() async {
        typealias Value = Int
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_int_optional_default() async {
        typealias Value = Int?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random(in: 0...100_000)
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_int_optional_set() async {
        typealias Value = Int?
        let defaultValue: Value = .random(in: 0...100_000)
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: String Tests
    
    func test_set_string() async {
        typealias Value = String
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = UUID().uuidString
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_string_optional_default() async {
        typealias Value = String?
        let defaultValue: Value = nil
        let expectedNewValue: Value = UUID().uuidString
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_string_optional_set() async {
        typealias Value = String?
        let defaultValue: Value = UUID().uuidString
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: String Array Tests
    
    func test_set_stringArray() async {
        typealias Value = [String]
        let defaultValue: Value = [UUID().uuidString, UUID().uuidString]
        let expectedNewValue: Value = [UUID().uuidString, UUID().uuidString]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_stringArray_optional_default() async {
        typealias Value = [String]?
        let defaultValue: Value = nil
        let expectedNewValue: Value = [UUID().uuidString, UUID().uuidString]
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_stringArray_optional_set() async {
        typealias Value = [String]?
        let defaultValue: Value = [UUID().uuidString, UUID().uuidString]
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: URL Tests
    
    func test_set_url() async {
        typealias Value = URL
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_url_optional_default() async {
        typealias Value = URL?
        let defaultValue: Value = nil
        let expectedNewValue: Value = URL(string: "https://superhighway.info")!
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_url_optional_defaultTrue() async {
        typealias Value = URL?
        let defaultValue: Value = URL(string: "https://kylehugh.es")!
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
}

// MARK: - Complex Setting Value Tests

extension UserDefaultsStorageTests {
    // MARK: RawRepresentable Tests
    
    func test_set_rawRepresentables() async {
        typealias Value = TestRawRepresentableStorable
        let defaultValue: Value = .caseOne
        let expectedNewValue: Value = .caseTwo
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_rawRepresentables_optional_default() async {
        typealias Value = TestRawRepresentableStorable?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .caseTwo
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_rawRepresentables_optional_set() async throws {
        typealias Value = TestRawRepresentableStorable?
        let defaultValue: Value = .caseOne
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
    
    // MARK: Codable Tests
    
    func test_set_codable() async {
        typealias Value = TestCodableStorable
        let defaultValue: Value = .random
        let expectedNewValue: Value = .random
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_codable_optional_default() async {
        typealias Value = TestCodableStorable?
        let defaultValue: Value = nil
        let expectedNewValue: Value = .random
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue = Value.decode(for: key, from: Value.extract(key, from: storage))
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_set_codable_optional_set() async throws {
        typealias Value = TestCodableStorable?
        let defaultValue: Value = .random
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
}
