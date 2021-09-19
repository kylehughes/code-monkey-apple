//
//  AsyncDoublyLinkedListTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 9/19/21.
//

import CodeMonkeyApple
import XCTest

final class AsyncDoublyLinkedListTests: XCTestCase {
    // MARK: - XCTestCase Implementation
    
    override func setUp() {
        // NO-OP
    }
    
    override func tearDown() {
        // NO-OP
    }
}

// MARK: - Tests

extension AsyncDoublyLinkedListTests {
    // MARK: Initialization Tests
    
    func test_init() async throws {
        let instance = AsyncDoublyLinkedList<Int>()
        
        await XCTAssertEqualAsync(await instance.count, 0)
        await XCTAssertNilAsync(await instance.head)
        await XCTAssertNilAsync(await instance.tail)
    }
    
    func test_init_singleValue() async {
        let value = 0
        let instance = AsyncDoublyLinkedList<Int>(value)

        await XCTAssertEqualAsync(await instance.count, 1)
//        await XCTAssertEqualAsync(await instance.head?.id, await instance.tail?.id)
//        await XCTAssertEqualAsync(await instance.head?.value, value)
        await XCTAssertNotNilAsync(await instance.head)
        await XCTAssertNotNilAsync(await instance.tail)
    }
}
