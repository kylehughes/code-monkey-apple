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
        
        await XCTAsyncAssertNil(await instance.head)
        await XCTAsyncAssertNil(await instance.tail)
    }
    
    func test_init_singleValue() async throws {
        let value = 0
        let instance = AsyncDoublyLinkedList<Int>(value)
        
        let headNode = try await XCTAsyncUnwrap(await instance.head)
        let tailNode = try await XCTAsyncUnwrap(await instance.tail)
        
        XCTAssertEqual(headNode.id, tailNode.id)

        await XCTAsyncAssertEqual(await headNode.value, value)
        await XCTAsyncAssertNotNil(await instance.head)
        await XCTAsyncAssertNotNil(await instance.tail)
    }
    
    // MARK: Removal Tests
    
    func test_removeTail_none() async {
        let instance = AsyncDoublyLinkedList<Int>()
        
        await instance.removeTail()
        
        await XCTAsyncAssertNil(await instance.tail)
    }
    
    func test_removeTail_many() async throws {
        let values = [1, 2, 3, 4]
        let instance = await AsyncDoublyLinkedList<Int>(values)
        
        let originalHeadNode = try await XCTAsyncUnwrap(await instance.head)
        let originalTailNode = try await XCTAsyncUnwrap(await instance.tail)
        let removedNode = try await XCTAsyncUnwrap(await instance.removeTail())
        let currentHeadNode = try await XCTAsyncUnwrap(await instance.head)
        let currentTailNode = try await XCTAsyncUnwrap(await instance.tail)
        
        XCTAssertEqual(originalHeadNode.id, currentHeadNode.id)
        XCTAssertEqual(originalTailNode.id, removedNode.id)
        XCTAssertNotEqual(originalTailNode.id, currentTailNode.id)
                
        await XCTAsyncAssertEqual(await currentTailNode.value, values.dropLast().last)
        await XCTAsyncAssertNil(await currentTailNode.next)
        await XCTAsyncAssertNotNil(await currentTailNode.previous)
        
        await XCTAsyncAssertEqual(await removedNode.value, values.last)
        await XCTAsyncAssertNil(await removedNode.next)
        await XCTAsyncAssertNil(await removedNode.previous)
    }
    
    func test_removeTail_one() async throws {
        let value = 1
        let instance = AsyncDoublyLinkedList<Int>(value)
        
        let removedNode = try await XCTAsyncUnwrap(await instance.removeTail())
        
        await XCTAsyncAssertNil(await instance.head)
        await XCTAsyncAssertNil(await instance.tail)
        
        await XCTAsyncAssertEqual(await removedNode.value, value)
        await XCTAsyncAssertNil(await removedNode.next)
        await XCTAsyncAssertNil(await removedNode.previous)
    }
    
    func test_removeTail_two() async throws {
        let values = [1, 2]
        let instance = await AsyncDoublyLinkedList<Int>(values)
        
        let originalHeadNode = try await XCTAsyncUnwrap(await instance.head)
        let originalTailNode = try await XCTAsyncUnwrap(await instance.tail)
        let removedNode = try await XCTAsyncUnwrap(await instance.removeTail())
        let currentHeadNode = try await XCTAsyncUnwrap(await instance.head)
        let currentTailNode = try await XCTAsyncUnwrap(await instance.tail)
        
        XCTAssertEqual(originalHeadNode.id, currentHeadNode.id)
        XCTAssertEqual(originalHeadNode.id, currentTailNode.id)
        XCTAssertEqual(originalTailNode.id, removedNode.id)
        XCTAssertNotEqual(originalTailNode.id, currentTailNode.id)
                
        await XCTAsyncAssertEqual(await currentTailNode.value, values.dropLast().last)
        await XCTAsyncAssertNil(await currentTailNode.next)
        await XCTAsyncAssertNil(await currentTailNode.previous)
        
        await XCTAsyncAssertEqual(await removedNode.value, values.last)
        await XCTAsyncAssertNil(await removedNode.next)
        await XCTAsyncAssertNil(await removedNode.previous)
    }
}
