//
//  AsyncDoublyLinkedList.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/19/21.
//  Copyright © 2020 Kyle Hughes. All rights reserved.
//

import Foundation

public final actor AsyncDoublyLinkedList<Value> {
    public private(set) var head: Node?
    public private(set) var tail: Node?
    
    internal nonisolated let id: UUID
    
    // MARK: Public Initialization
    
    public init<Sequence>(
        _ initialValues: Sequence
    ) async where Sequence: Swift.Sequence, Sequence.Element == Value {
        self.init()
        
        // TODO: can this not be async?
        
        for value in initialValues {
            await append(value)
        }
    }
    
    public init(_ initialValue: Value) {
        let id = UUID()
        self.id = id
        
        let initialNode = Node(initialValue, in: id)
        head = initialNode
        tail = initialNode
    }
    
    public init() {
        id = UUID()
        head = nil
        tail = nil
    }
    
    // MARK: Public Instance Interface
    
    /// - Complexity: O(1)
    public var isEmpty: Bool {
        head == nil
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func append(_ value: Value) async -> Node {
        let node = Node(value, in: self)
        
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
        let node = Node(value, in: self)
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
        let node = Node(value, in: self)
        
        guard let head = head, let _ = tail else {
            self.head = node
            self.tail = node
            
            return node
        }
        
        await head.update(previous: node)
        self.head = node
        
        return node
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func remove(_ node: Node) async -> Node {
        guard node.listID == id else {
            return node
        }
        
        return await _remove(node)
    }
    
    /// - Complexity: O(1)
    public func remove(after node: Node) async {
        guard node.listID == id else {
            return
        }
        
        await _remove(after: node)
    }
    
    /// - Complexity: O(1)
    public func remove(afterAndIncluding node: Node) async {
        guard node.listID == id else {
            return
        }
        
        await _remove(afterAndIncluding: node)
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

        return await _remove(head)
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func removeTail() async -> Node? {
        guard let tail = tail else {
            return nil
        }

        return await _remove(tail)
    }
    
    public nonisolated func reversed() -> Reversed {
        Reversed(self)
    }
    
    // MARK: Private Instance Interface
    
    /// - Complexity: O(1)
    @discardableResult
    private func _remove(_ node: Node) async -> Node {
        if node === head {
            head = await node.next
        }
        
        if node === tail {
            tail = await node.previous
        }
        
        await node.previous?.update(next: node.next)
                
        return node
    }
    
    /// - Complexity: O(1)
    // TODO: this apparently doesn't work
    private func _remove(after node: Node) async {
        await node.update(next: nil)
        tail = node
    }
    
    /// - Complexity: O(1)
    private func _remove(afterAndIncluding node: Node) async {
        tail = await node.previous
        await node.previous?.update(next: nil)
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
            
            await _remove(node)
            
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
            self.current = await list.head
            
            return self.current
        }
        
        self.current = await current.next
        
        return self.current
    }
}

// MARK: - AsyncDoublyLinkedList.Node Definition

extension AsyncDoublyLinkedList {
    public final actor Node: Identifiable {
        public nonisolated let id: UUID
        
        public private(set) var next: Node?
        public private(set) var previous: Node?
        public private(set) var value: Value
        
        internal nonisolated let listID: UUID
        
        // MARK: Internal Initialization
        
        internal init(_ value: Value, in list: AsyncDoublyLinkedList) {
            self.init(value, in: list.id)
        }
        
        internal init(_ value: Value, in listID: UUID) {
            self.value = value
            self.listID = listID
            
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
            self.current = await list.tail
            
            return self.current
        }
        
        self.current = await current.previous
        
        return self.current
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
