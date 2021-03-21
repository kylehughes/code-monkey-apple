//
//  Subdomain.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

public struct Subdomain: Equatable, Hashable, Codable, RawRepresentable {
    public let rawValue: String
    
    // MARK: Public Initialization
    
    public init<StringType>(rawValue: StringType) where StringType: StringProtocol {
        self.rawValue = String(rawValue)
    }
    
    // MARK: Public Instance Interface
    
    public func adding<StringType>(subdomain: StringType) -> DomainName where StringType: StringProtocol {
        adding(subdomain: Subdomain(rawValue: subdomain))
    }
    
    public func adding(subdomain: Subdomain) -> DomainName {
        DomainName(subdomains: [self, subdomain])
    }
}

// MARK: - ExpressibleByStringLiteral Extension

extension Subdomain: ExpressibleByExtendedGraphemeClusterLiteral {
    // MARK: Public Initialization
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(rawValue: value)
    }
}


extension Subdomain: ExpressibleByStringLiteral {
    // MARK: Public Initialization
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}

extension Subdomain: ExpressibleByUnicodeScalarLiteral {
    // MARK: Public Initialization
    
    public init(unicodeScalarLiteral value: String) {
        self.init(rawValue: value)
    }
}
