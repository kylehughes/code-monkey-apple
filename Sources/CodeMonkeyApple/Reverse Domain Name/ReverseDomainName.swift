//
//  ReverseDomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

public struct ReverseDomainName: RawRepresentable {
    // MARK: Public Instance Properties
    
    public let rawValue: String
    
    // MARK: Public Initialization
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    // MARK: Public Instance Interface
    
    public func adding(subdomain: String) -> ReverseDomainName {
        ReverseDomainName(rawValue: rawValue + "." + subdomain)
    }
}

// MARK: - Constants

extension ReverseDomainName {
    public static let es = Self.init(rawValue: "es")
    public static let es_kylehugh = Self.es.adding(subdomain: "kylehugh")
    public static let es_kylehugh_codemonkey = Self.es_kylehugh.adding(subdomain: "code-monkey")
    public static let es_kylehugh_codemonkey_apple = Self.es_kylehugh_codemonkey.adding(subdomain: "apple")
}
