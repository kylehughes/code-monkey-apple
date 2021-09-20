//
//  AsyncDoublyLinkedList.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/19/21.
//  Copyright © 2020 Kyle Hughes. All rights reserved.
//

import Foundation

public final actor AsyncDoublyLinkedList<Value> {
    public private(set) var count: Int
    public private(set) var head: Node?
    public private(set) var tail: Node?
    
    // MARK: Public Initialization
    
    public convenience init<Sequence>(
        _ initialValues: Sequence
    ) async where Sequence: Swift.Sequence, Sequence.Element == Value {
        self.init()
        
        for value in initialValues {
            await append(value)
        }
    }
    
    public convenience init(_ initialValue: Value) {
        self.init(initialNode: Node(initialValue))
    }
    
    public init() {
        count = 0
        head = nil
        tail = nil
    }
    
    // MARK: Private Initialization
    
    private init(initialNode: Node) {
        count = 1
        head = initialNode
        tail = initialNode
    }
    
    // MARK: Public Static Interface
    
    public static func makeWithNode(_ initialValue: Value) -> (AsyncDoublyLinkedList, Node) {
        let initialNode = Node(initialValue)
        let list = Self(initialNode: initialNode)
        
        return (list, initialNode)
    }
    
    // MARK: Public Instance Interface
    
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        head == nil
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func append(_ value: Value) async -> Node {
        defer {
            count += 1
        }
        
        let node = Node(value)
        
        guard let _ = head, let tail = tail else {
            self.head = node
            self.tail = node
            
            return node
        }
        
        await tail.update(next: node)
        self.tail = node
        
        return node
    }
    
    /// - Complexity: O(1)
    public func append(value: Value) async {
        await append(value)
    }
    
    /// - Complexity: O(n)
    public func getNode(at index: Int) async -> Node? {
        var currentIndex = 0

        for await node in self {
            guard currentIndex == index else {
                currentIndex += 1
                continue
            }
            
            return node
        }
        
        return nil
    }
    
    /// - Complexity: O(n)
    public func getValue(at index: Int) async -> Value? {
        await getNode(at: index)?.value
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func insert(_ value: Value, after existingNode: Node) async -> Node {
        let node = Node(value)
        await existingNode.update(next: node)
        
        return node
    }
    
    /// - Complexity: O(1)
    public func insert(value: Value, after existingNode: Node) async {
        await insert(value, after: existingNode)
    }
        
    /// - Complexity: O(1)
    @discardableResult
    public func prepend(_ value: Value) async -> Node {
        let node = Node(value)
        
        guard let head = head, let _ = tail else {
            self.head = node
            self.tail = node
            
            return node
        }
        
        await head.update(previous: node)
        self.head = node
        
        count += 1
        
        return node
    }
    
    /// - Complexity: O(1)
    public func prepend(value: Value) async -> Node {
        await prepend(value)
    }
    
    /// - Complexity: O(1)
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func removeHead() async -> Node? {
        guard let head = head else {
            return nil
        }

        return await remove(node: head)
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func removeTail() async -> Node? {
        guard let tail = tail else {
            return nil
        }

        return await remove(node: tail)
    }
    
    public nonisolated func reversed() -> Reversed {
        Reversed(self)
    }
    
    // MARK: Private Instance Interface
    
    /// - Complexity: O(1)
    @discardableResult
    private func remove(node: Node) async -> Node {
        if node === head {
            head = await node.next
        }
        
        if node === tail {
            tail = await node.previous
        }
        
        await node.previous?.update(next: node.next)
        
        count -= 1
        
        return node
    }
}

// MARK: - AsyncSequence Extension

extension AsyncDoublyLinkedList: AsyncSequence {
    public typealias Element = Node
    
    // MARK: Public Instance Interface
    
    public nonisolated func makeAsyncIterator() -> Iterator {
        Iterator(list: self)
    }
}

// MARK: - Extension where Value: Equatable

extension AsyncDoublyLinkedList where Value: Equatable {
    // MARK: Public Instance Interface
    
    /// - Complexity: O(n)
    @discardableResult
    public func insert(_ value: Value, after existingValue: Value) async -> Node? {
        for await node in self {
            guard await node.value == existingValue else {
                continue
            }
            
            return await insert(value, after: node)
        }
        
        return nil
    }
    
    /// - Complexity: O(n)
    public func insert(value: Value, after existingValue: Value) async {
        await insert(value, after: existingValue)
    }
    
    /// - Complexity: O(n)
    public func remove(_ value: Value) async {
        for await node in self {
            guard await node.value == value else {
                continue
            }
            
            await remove(node: node)
            
            break
        }
    }
}

// MARK: - AsyncDoublyLinkedList.Iterator Definition

extension AsyncDoublyLinkedList {
    public struct Iterator {
        public let list: AsyncDoublyLinkedList
        
        public private(set) var current: Node?
        
        // MARK: Public Initialization
        
        public init(list: AsyncDoublyLinkedList) {
            self.list = list
        }
    }
}

// MARK: - AsyncIteratorProtocol Extension

extension AsyncDoublyLinkedList.Iterator: AsyncIteratorProtocol {
    // MARK: Public Instance Interface
    
    public mutating func next() async -> AsyncDoublyLinkedList.Node? {
        guard let current = current else {
            let head = await list.head
            
            self.current = head
            
            return head
        }
        
        let next = await current.next
        
        self.current = next
        
        return next
    }
}

// MARK: - AsyncDoublyLinkedList.Node Definition

extension AsyncDoublyLinkedList {
    public final actor Node: Identifiable {
        public nonisolated let id: UUID
        
        public private(set) var next: Node?
        public private(set) var previous: Node?
        public private(set) var value: Value
        
        // MARK: Public Initialization
        
        public init(_ value: Value) {
            self.value = value
            
            id = UUID()
            next = nil
            previous = nil
        }
        
        // MARK: Public Instance Interface
        
        public var hasNext: Bool {
            next != nil
        }
        
        public var hasPrevious: Bool {
            previous != nil
        }
        
        public var isTail: Bool {
            next != nil
        }
        
        func hasNext(_ count: Int) async -> Bool {
            guard 0 < count else {
                return true
            }
            
            var current = self
            
            for _ in 0 ..< count {
                guard let next = await current.next else {
                    return false
                }
                
                current = next
            }
            
            return true
        }
        
        public func update(value: Value) {
            self.value = value
        }
        
        // MARK: Fileprivate Instance Interface
        
        fileprivate func update(next: Node?) async {
            let existingNext = self.next
            
            set(next: next)
            await next?.set(next: existingNext)
            await next?.set(previous: self)
            await existingNext?.set(previous: next)
        }
        
        fileprivate func update(previous: Node?) async {
            let existingPrevious = self.previous
            
            set(previous: previous)
            await previous?.set(next: self)
            await previous?.set(previous: existingPrevious)
            await existingPrevious?.set(next: previous)
        }
        
        // MARK: Private Instance Interface
        
        private func set(next: Node?) {
            self.next = next
        }
        
        private func set(previous: Node?) {
            self.previous = previous
        }
    }
}

// MARK: - AsyncDoublyLinkedList.ReverseIterator Definition

extension AsyncDoublyLinkedList {
    public struct ReverseIterator {
        public let list: AsyncDoublyLinkedList
        
        public private(set) var current: Node?
        
        // MARK: Public Initialization
        
        public init(list: AsyncDoublyLinkedList) {
            self.list = list
        }
    }
}

// MARK: - AsyncIteratorProtocol Extension

extension AsyncDoublyLinkedList.ReverseIterator: AsyncIteratorProtocol {
    // MARK: Public Instance Interface
    
    public mutating func next() async -> AsyncDoublyLinkedList.Node? {
        guard let current = current else {
            let tail = await list.tail
            
            self.current = tail
            
            return tail
        }
        
        let previous = await current.previous
        
        self.current = previous
        
        return previous
    }
}

// MARK: - AsyncDoublyLinkedList.Reversed Definition

extension AsyncDoublyLinkedList {
    public struct Reversed {
        private let base: AsyncDoublyLinkedList
        
        // MARK: Internal Initialization
        
        init(_ base: AsyncDoublyLinkedList) {
            self.base = base
        }
    }
}

// MARK: - AsyncSequence Extension

extension AsyncDoublyLinkedList.Reversed: AsyncSequence {
    public typealias Element = AsyncDoublyLinkedList.Node
    
    // MARK: Public Instance Interface
    
    public func makeAsyncIterator() -> AsyncDoublyLinkedList.ReverseIterator {
        AsyncDoublyLinkedList.ReverseIterator(list: base)
    }
}
