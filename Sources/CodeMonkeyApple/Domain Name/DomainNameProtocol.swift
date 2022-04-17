//
//  DomainNameProtocol.swift
//  CodeMonkeyAple
//
//  Created by Kyle Hughes on 3/21/21.
//

public protocol DomainNameProtocol: Hashable, Codable, RawRepresentable {
    // MARK: Public Initialization
    
    init(rawValue: String)
    init(subdomains: [Subdomain])
    
    // MARK: Public Instance Interface
    
    var subdomains: [Subdomain] { get }
    
    mutating func add<Other>(other: Other) where Other: DomainNameProtocol
    mutating func add(subdomain: Subdomain)
    func adding<Other>(other: Other) -> Self where Other: DomainNameProtocol
    func adding(subdomain: Subdomain) -> Self
}

// MARK: - Default Implementation

extension DomainNameProtocol {
    // MARK: Public Instance Interface
    
    public mutating func add(subdomain: String) {
        add(subdomain: Subdomain(rawValue: subdomain))
    }
    
    public mutating func add(subdomain: Substring) {
        add(subdomain: String(subdomain))
    }
    
    public func adding(subdomain: String) -> Self {
        adding(subdomain: Subdomain(rawValue: subdomain))
    }
    
    public func adding(subdomain: Substring) -> Self {
        adding(subdomain: String(subdomain))
    }
}
