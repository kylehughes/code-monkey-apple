//
//  ArrayBuilder.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/20/22.
//

public protocol ArrayBuilderProtocol {
    associatedtype Element
}

// MARK: - Statement Blocks

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildBlock(_ elements: [Element]...) -> [Element] {
        elements.flatMap { $0 }
    }
}

// MARK: - Optionals

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildIf(_ component: [Element]?) -> [Element] {
        component ?? []
    }
}

// MARK: - Conditionals

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildEither(first: [Element]) -> [Element] {
        first
    }
    
    public static func buildEither(second: [Element]) -> [Element] {
        second
    }
}

// MARK: - Arrays

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildArray(_ elements: [[Element]]) -> [Element] {
        elements.flatMap{ $0 }
    }
}

// MARK: - Expressions

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildExpression(_ element: Element) -> [Element] {
        [element]
    }
    
    public static func buildExpression(_ elements: [Element]) -> [Element] {
        elements
    }
    
    public static func buildExpression<Other>(
        _ elements: Other
    ) -> [Element] where Other: Sequence, Other.Element == Element {
        [Element].init(elements)
    }
}

// MARK: - Final Results

extension ArrayBuilderProtocol {
    // NO-OP, can be implemented by consumer if desired
}

// MARK: - Limited Availability

extension ArrayBuilderProtocol {
    // MARK: Public Static Interface
    
    public static func buildLimitedAvailability(_ elements: [Element]) -> [Element] {
        elements
    }
}
