//
//  UserDefaultsStorageTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 3/28/22.
//

import Foundation
import XCTest

@testable import CodeMonkeyApple

final class UserDefaultsStorageTests: XCTestCase {
    private let storage = UserDefaults.standard
    
    // MARK: XCTestCase Implementation
    
    override func tearDown() async throws {
        storage.dictionaryRepresentation().keys.forEach(storage.removeObject)
    }
}

// MARK: - Tests for Built-In Types

extension UserDefaultsStorageTests {
    // MARK: Tests
    
    func test_bool() {
        StorableTestHarness<Bool>(firstValue: true, secondValue: false, storage: .standard).test()
    }
    
    func test_data() {
        StorableTestHarness<Data>(
            firstValue: UUID().uuidString.data(using: .utf8)!,
            secondValue: UUID().uuidString.data(using: .utf8)!,
            storage: .standard
        ).test()
    }
    
    func test_date() {
        StorableTestHarness<Date>(
            firstValue: Date(timeIntervalSince1970: .random(in: 0 ... 100_000)),
            secondValue: Date(timeIntervalSince1970: .random(in: 0 ... 100_000)),
            storage: .standard
        ).test()
    }
    
    func test_double() {
        StorableTestHarness<Double>(
            firstValue: .random(in: 0...100_000),
            secondValue: .random(in: 0...100_000),
            storage: .standard
        ).test()
    }
    
    func test_float() {
        StorableTestHarness<Float>(
            firstValue: .random(in: 0...100_000),
            secondValue: .random(in: 0...100_000),
            storage: .standard
        ).test()
    }
    
    func test_int() {
        StorableTestHarness<Int>(
            firstValue: .random(in: 0...100_000),
            secondValue: .random(in: 0...100_000),
            storage: .standard
        ).test()
    }
    
    func test_string() {
        StorableTestHarness<String>(
            firstValue: UUID().uuidString,
            secondValue: UUID().uuidString,
            storage: .standard
        ).test()
    }
    
    func test_stringArray() {
        StorableTestHarness<[String]>(
            firstValue: [UUID().uuidString, UUID().uuidString, UUID().uuidString],
            secondValue: [UUID().uuidString, UUID().uuidString, UUID().uuidString],
            storage: .standard
        ).test()
    }
    
    func test_url() {
        StorableTestHarness<URL>(
            firstValue: URL(string: "https://kylehugh.es")!,
            secondValue: URL(string: "https://superhighway.info")!,
            storage: .standard
        ).test()
    }
}

// MARK: - Tests for Complex Types

extension UserDefaultsStorageTests {
    // MARK: Tests
    
    func test_codable() {
        StorableTestHarness<TestCodableStorable>(
            firstValue: .random,
            secondValue: .random,
            storage: .standard
        ).test()
    }
    
    func test_rawRepresentable() {
        StorableTestHarness<TestRawRepresentableStorable>(
            firstValue: .caseOne,
            secondValue: .caseTwo,
            storage: .standard
        ).test()
    }
}
