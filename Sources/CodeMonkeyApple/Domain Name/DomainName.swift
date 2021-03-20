//
//  ReverseDomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/15/21.
//

public struct DomainName: RawRepresentable {
    // MARK: Public Instance Properties
    
    public private(set) var rawValue: String
    public private(set) var tokens: [String]
    
    // MARK: Public Initialization
    
    public init(rawValue: String) {
        self.rawValue = rawValue
        
        tokens = Self.makeTokens(from: rawValue)
    }
    
    public init(tokens: [String]) {
        self.tokens = tokens
        
        rawValue = Self.makeRawValue(from: tokens)
    }
    
    // MARK: Public Instance Interface
    
    public mutating func add(subdomain: String) {
        tokens.insert(subdomain, at: 0)
        rawValue = Self.makeRawValue(from: tokens)
    }
    
    public func adding(subdomain: String) -> DomainName {
        var newTokens = tokens
        newTokens.insert(subdomain, at: 0)
        
        return DomainName(tokens: newTokens)
    }
    
    // MARK: Private Static Interface
    
    private static func makeRawValue(from tokens: [String]) -> String {
        tokens.joined(separator: ".")
    }
    
    private static func makeTokens(from rawValue: String) -> [String] {
        rawValue
            .split(separator: ".")
            .map(String.init)
    }
}

// MARK: - Constants

extension DomainName {
    public static let es = DomainName(rawValue: "es")
    public static let kylehugh_es = es.adding(subdomain: "kylehugh")
}
