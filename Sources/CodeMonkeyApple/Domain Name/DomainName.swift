//
//  ReverseDomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/15/21.
//

public struct DomainName: Equatable, Hashable, Codable, RawRepresentable, Sendable {
    // MARK: Public Instance Properties

    public private(set) var rawValue: String
    public private(set) var subdomains: [Subdomain]
}

// MARK: - Constants

extension DomainName {
    public static let es = DomainName(rawValue: "es")
    public static let kylehugh_es = es.adding(subdomain: "kylehugh")
}

// MARK: - DomainNameProtocol Extension

extension DomainName: DomainNameProtocol {
    // MARK: Public Initialization
    
    public init(rawValue: String) {
        self.rawValue = rawValue
        
        subdomains = rawValue.makeSubdomains()
    }
    
    public init(subdomains: [Subdomain]) {
        self.subdomains = subdomains
        
        rawValue = subdomains.makeRawValue()
    }
    
    // MARK: Public Instance Interface
    
    public mutating func add<Other>(other: Other) where Other: DomainNameProtocol {
        subdomains.insert(contentsOf: other.subdomains, at: 0)
        rawValue = subdomains.makeRawValue()
    }
    
    public mutating func add(subdomain: Subdomain) {
        subdomains.insert(subdomain, at: 0)
        rawValue = subdomains.makeRawValue()
    }
    
    public func adding<Other>(other: Other) -> Self where Other: DomainNameProtocol {
        var newSubdomains = subdomains
        newSubdomains.insert(contentsOf: other.subdomains, at: 0)
        
        return Self(subdomains: newSubdomains)
    }
    
    public func adding(subdomain: Subdomain) -> Self {
        var newSubdomains = subdomains
        newSubdomains.insert(subdomain, at: 0)
        
        return Self(subdomains: newSubdomains)
    }
}

