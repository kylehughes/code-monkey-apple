//
//  Orderable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/30/21.
//

public protocol Orderable {
    associatedtype Ordinal: SignedInteger
    
    // MARK: Instance Interface
    
    var ordinal: Ordinal { get }
}

// MARK: - Extension for Collection

extension Collection where Element: Orderable {
    // MARK: Public Instance Interface
    
    public var largestOrdinal: Element.Ordinal? {
        ordered().map(\.ordinal).last
    }
    
    public var nextOrdinal: Element.Ordinal {
        guard let largestOrdinal = largestOrdinal else {
            return 1
        }
        
        return largestOrdinal + 1
    }
    
    public func ordered() -> [Element] {
        sorted {
            $0.ordinal < $1.ordinal
        }
    }
}
