//
//  CurrentHashTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 11/30/22.
//

import CodeMonkeyApple
import XCTest

final class DerivedHashTests: XCTestCase {
    // MARK: XCTestCase Implementation
    
    override func setUp() {
        // NO-OP
    }
    
    override func tearDown() {
        // NO-OP
    }
}

// MARK: - Hash Tests

extension DerivedHashTests {
    // MARK: Tests
    
    func test_initialization_equivalent() {
        XCTAssertEqual(DerivedHash("Label").value, DerivedHash("Label").value)
    }
    
    func test_initialization_unique() {
        XCTAssertNotEqual(DerivedHash("First").value, DerivedHash("Second").value)
    }
    
    func test_dependencyDidUpdate_whenDependencyDidNotUpdate() {
        expectDependentHashesAreEqual { dependency, first, second in
            first.dependencyDidUpdate()
        }
    }
    
    func test_dependencyDidUpdate_whenDependencyNotUpdate() {
        expectDependentHashesAreDifferent { dependency, first, second in
            dependency._value += 1
            first.dependencyDidUpdate()
        }
    }
    
    func test_update_whenDependencyDidNotUpdate() {
        expectDependentHashesAreEqual { dependency, first, second in
            first.update()
        }
    }
    
    func test_update_whenDependencyDidUpdate() {
        expectDependentHashesAreDifferent { dependency, first, second in
            dependency._value += 1
            first.update()
        }
    }
    
    // MARK: Private Instance Interface
    
    private func expectDependentHashesAreEqual(after operation: (MockHash, DerivedHash, DerivedHash) -> Void) {
        let dependency = MockHash("Dependency", value: 1)
        
        let first = DerivedHash("First")
            .addingDependency(on: dependency)
        
        let second = DerivedHash("Second")
            .addingDependency(on: first)
        
        let firstValueBeforeUpdate = first.value
        let secondValueBeforeUpdate = second.value
        
        operation(dependency, first, second)
        
        XCTAssertEqual(firstValueBeforeUpdate, first.value)
        XCTAssertEqual(secondValueBeforeUpdate, second.value)
    }
    
    private func expectDependentHashesAreDifferent(after operation: (MockHash, DerivedHash, DerivedHash) -> Void) {
        let dependency = MockHash("Dependency", value: 1)
        
        let first = DerivedHash("First")
            .addingDependency(on: dependency)
        
        let second = DerivedHash("Second")
            .addingDependency(on: first)
        
        let firstValueBeforeUpdate = first.value
        let secondValueBeforeUpdate = second.value
        
        operation(dependency, first, second)
        
        XCTAssertNotEqual(firstValueBeforeUpdate, first.value)
        XCTAssertNotEqual(secondValueBeforeUpdate, second.value)
    }
}
