//
//  DoublyLinkedList.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/19/21.
//  Copyright © 2020 Kyle Hughes. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

public final class DoublyLinkedList<Value> {
    public private(set) var count: Int
    public private(set) var head: Node?
    public private(set) var tail: Node?
    
    // MARK: Public Initialization
    
    public init() {
        count = 0
        head = nil
        tail = nil
    }
    
    public init(_ initialValue: Value) {
        count = 1
        
        let initialNode = Node(value: initialValue)
        head = initialNode
        tail = initialNode
    }
    
    // MARK: Private Initialization
    
    private init(initialNode: Node) {
        count = 1
        head = initialNode
        tail = initialNode
    }
    
    // MARK: Public Static Interface
    
    public static func makeWithNode(_ initialValue: Value) -> (DoublyLinkedList, Node) {
        let initialNode = Node(value: initialValue)
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
    public func append(_ value: Value) -> Node {
        defer {
            count += 1
        }
        
        let node = Node(value: value)
        
        guard let _ = head, let tail = tail else {
            self.head = node
            self.tail = node
            
            return node
        }
        
        tail.update(next: node)
        self.tail = node
        
        return node
    }
    
    /// - Complexity: O(1)
    public func append(value: Value) {
        append(value)
    }
    
    /// - Complexity: O(n)
    public func getNode(at index: Int) -> Node? {
        var currentIndex = 0

        for node in self {
            guard currentIndex == index else {
                currentIndex += 1
                continue
            }
            
            return node
        }
        
        return nil
    }
    
    /// - Complexity: O(n)
    public func getValue(at index: Int) -> Value? {
        getNode(at: index)?.value
    }
    
    /// - Complexity: O(1)
    @discardableResult
    public func insert(_ value: Value, after existingNode: Node) -> Node {
        let node = Node(value: value)
        existingNode.update(next: node)
        
        return node
    }
    
    /// - Complexity: O(1)
    public func insert(value: Value, after existingNode: Node) {
        insert(value, after: existingNode)
    }
        
    /// - Complexity: O(1)
    @discardableResult
    public func prepend(_ value: Value) -> Node {
        let node = Node(value: value)
        
        guard let head = head, let _ = tail else {
            self.head = node
            self.tail = node
            
            return node
        }
        
        head.update(previous: node)
        self.head = node
        
        count += 1
        
        return node
    }
    
    /// - Complexity: O(1)
    public func prepend(value: Value) -> Node {
        prepend(value)
    }
    
    /// - Complexity: O(1)
    public func remove(node: Node) {
        if node === head {
            head = nil
        }
        
        if node === tail {
            tail = nil
        }
        
        node.previous?.update(next: node.next)
    }
    
    /// - Complexity: O(1)
    public func removeAll() {
        head = nil
        tail = nil
    }
}

// MARK: - IteratorProtocol & Sequence Extension

extension DoublyLinkedList: Sequence {
    // MARK: Public Instance Interface
    
    public func makeIterator() -> Iterator {
        Iterator(list: self)
    }
}

// MARK: - Extension where Value: Equatable

extension DoublyLinkedList where Value: Equatable {
    // MARK: Public Instance Interface
    
    /// - Complexity: O(n)
    @discardableResult
    public func insert(_ value: Value, after existingValue: Value) -> Node? {
        for node in self {
            guard node.value == existingValue else {
                continue
            }
            
            return insert(value, after: node)
        }
        
        return nil
    }
    
    /// - Complexity: O(n)
    public func insert(value: Value, after existingValue: Value) {
        insert(value, after: existingValue)
    }
    
    /// - Complexity: O(n)
    public func remove(_ value: Value) {
        for node in self {
            guard node.value == value else {
                continue
            }
            
            remove(node: node)
            
            break
        }
    }
}

// MARK: - DoublyLinkedList.Node Definition

extension DoublyLinkedList {
    public final class Node: ObservableObject, Identifiable {
        public let id: UUID
        
        public private(set) var next: Node?
        public private(set) var previous: Node?
        
        public private(set) var value: Value {
            willSet {
                DispatchQueue.main.async {
                    withAnimation {
                        // TODO: Get this out of here... somehow.
                        self.objectWillChange.send()
                    }
                }
            }
        }
        
        // MARK: Public Initialization
        
        public init(value: Value) {
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
        
        func hasNext(_ count: Int) -> Bool {
            guard 0 < count else {
                return true
            }
            
            var current = self
            
            for _ in 0 ..< count {
                guard let next = current.next else {
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
        
        fileprivate func update(next: Node?) {
            let existingNext = self.next
            
            self.next = next
            
            next?.next = existingNext
            next?.previous = self
            
            existingNext?.previous = next
        }
        
        fileprivate func update(previous: Node?) {
            let existingPrevious = self.previous
            
            self.previous = previous
            
            previous?.next = self
            previous?.previous = existingPrevious
            
            existingPrevious?.next = previous
        }
    }
}

// MARK: - Equatable Extension where Value: Equatable

extension DoublyLinkedList.Node: Equatable where Value: Equatable {
    // MARK: Public Static Interface
    
    public static func == (lhs: DoublyLinkedList<Value>.Node, rhs: DoublyLinkedList<Value>.Node) -> Bool {
        lhs.next == rhs.next &&
        lhs.previous == rhs.previous &&
        lhs.value == rhs.value
    }
}

// MARK: - Hashable Extension where Value: Hashable

extension DoublyLinkedList.Node: Hashable where Value: Hashable {
    // MARK: Public Instance Interface
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(next)
        hasher.combine(previous)
        hasher.combine(value)
    }
}

// MARK: - DoublyLinkedList.Iterator Definition

extension DoublyLinkedList {
    public struct Iterator {
        public let list: DoublyLinkedList
        
        public private(set) var current: Node?
        
        // MARK: Public Initialization
        
        public init(list: DoublyLinkedList) {
            self.list = list
            
            current = list.head
        }
        
        // MARK: Public Instance Interface
        
        public var hasNext: Bool {
            guard let current = current else {
                return list.head != nil
            }
            
            return current.hasNext
        }
        
        public var hasPrevious: Bool {
            current?.hasPrevious ?? false
        }
        
        public mutating func previous() -> DoublyLinkedList.Node? {
            current = current?.previous
            
            return current
        }
    }
}

// MARK: - IteratorProtocol Extension

extension DoublyLinkedList.Iterator: IteratorProtocol {
    // MARK: Public Instance Interface
    
    public mutating func next() -> DoublyLinkedList.Node? {
        guard let current = current else {
            let head = list.head
            
            self.current = head
            
            return head
        }
        
        let next = current.next
        
        self.current = next
        
        return next
    }
}
