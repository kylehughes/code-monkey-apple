//
//  StorableTestHarness.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/18/22.
//

import Foundation
import XCTest

@testable import CodeMonkeyApple

struct StorableTestHarness<Target> where Target: Equatable & Storable {
    private let firstValue: Target
    private let secondValue: Target
    private let storage: UserDefaults
    
    // MARK: Internal Initialization
    
    init(firstValue: Target, secondValue: Target, storage: UserDefaults) {
        self.firstValue = firstValue
        self.secondValue = secondValue
        self.storage = storage
    }
    
    // MARK: Getting Value Tests
    
    func test() {
        test_nonoptional()
        test_optional_first()
        test_optional_second()
    }
    
    func test_nonoptional() {
        typealias Value = Target
        let defaultValue: Value = firstValue
        let expectedNewValue: Value = secondValue
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_optional_first() {
        typealias Value = Target?
        let defaultValue: Value = nil
        let expectedNewValue: Value = secondValue
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        let newValue: Value = storage.get(key)
        
        XCTAssertEqual(newValue, expectedNewValue)
    }
    
    func test_optional_second() {
        typealias Value = Target?
        let defaultValue: Value = firstValue
        let expectedNewValue: Value = nil
        
        let key = StorageKey<Value>(id: UUID().uuidString, defaultValue: defaultValue)
        storage.set(key, to: expectedNewValue)
        
        XCTAssertNil(storage.object(forKey: key.id))
    }
}
