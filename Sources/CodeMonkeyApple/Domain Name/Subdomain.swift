//
//  Subdomain.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

public struct Subdomain: Equatable, Hashable, Codable, RawRepresentable {
    public let rawValue: String
    
    // MARK: Public Initialization
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(rawValue: Substring) {
        self.rawValue = String(rawValue)
    }
    
    // MARK: Public Instance Interface
    
    public func adding(subdomain: String) -> DomainName {
        adding(subdomain: Subdomain(rawValue: subdomain))
    }
    
    public func adding(subdomain: Substring) -> DomainName {
        adding(subdomain: Subdomain(rawValue: subdomain))
    }
    
    public func adding(subdomain: Subdomain) -> DomainName {
        DomainName(subdomains: [self, subdomain])
    }
}

// MARK: - ExpressibleByExtendedGraphemeClusterLiteral Extension

extension Subdomain: ExpressibleByExtendedGraphemeClusterLiteral {
    // MARK: Public Initialization
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(rawValue: value)
    }
}

// MARK: - ExpressibleByStringLiteral Extension

extension Subdomain: ExpressibleByStringLiteral {
    // MARK: Public Initialization
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

// MARK: - ExpressibleByUnicodeScalarLiteral Extension

extension Subdomain: ExpressibleByUnicodeScalarLiteral {
    // MARK: Public Initialization
    
    public init(unicodeScalarLiteral value: String) {
        self.init(rawValue: value)
    }
}
