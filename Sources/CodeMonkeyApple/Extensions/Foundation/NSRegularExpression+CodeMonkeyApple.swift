//
//  NSRegularExpression+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/28/21.
//

import Foundation

extension NSRegularExpression {
    // MARK: Public Initialization
    
    public convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern)")
        }
    }
    
    // MARK: Public Instance Interface
    
    public func enumerateMatches(
        in string: String,
        using block: (NSTextCheckingResult?, NSRegularExpression.MatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Void
    ) {
        enumerateMatches(in: string, options: [], range: Self.makeFullRange(for: string), using: block)
    }
    
    public func firstMatch(in string: String) -> NSTextCheckingResult? {
        firstMatch(in: string, options: [], range: Self.makeFullRange(for: string))
    }
    
    public func matches(_ string: String) -> Bool {
        firstMatch(in: string, options: [], range: Self.makeFullRange(for: string)) != nil
    }
    
    // MARK: Private Static Interface
    
    private static func makeFullRange(for string: String) -> NSRange {
        NSRange(location: 0, length: string.utf8.count)
    }
}
