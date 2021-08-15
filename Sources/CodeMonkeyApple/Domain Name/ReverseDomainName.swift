//
//  ReverseDomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

public struct ReverseDomainName: Equatable, Hashable, Codable, RawRepresentable {
    // MARK: Public Instance Properties
    
    public private(set) var rawValue: String
    public private(set) var subdomains: [Subdomain]
}

// MARK: - Constants

extension ReverseDomainName {
    public static let es = ReverseDomainName(rawValue: "es")
    public static let es_computertechniqu = es.adding(subdomain: "computertechniqu")
    public static let es_computertechniqu_rankThings = es_computertechniqu.adding(subdomain: "rank-things")
    public static let es_computertechniqu_superHeadache = es_computertechniqu.adding(subdomain: "super-headache")
    public static let es_kylehugh = es.adding(subdomain: "kylehugh")
    public static let es_kylehugh_codeMonkey = es_kylehugh.adding(subdomain: "code-monkey")
    public static let es_kylehugh_codeMonkey_apple = es_kylehugh_codeMonkey.adding(subdomain: "apple")
    public static let es_kylehugh_informationSuperhighway = es_kylehugh.adding(subdomain: "information-superhighway")
}

// MARK: - DomainNameProtocol Extension

extension ReverseDomainName: DomainNameProtocol {
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
        subdomains.append(contentsOf: other.subdomains)
        rawValue = subdomains.makeRawValue()
    }
    
    public mutating func add(subdomain: Subdomain) {
        subdomains.append(subdomain)
        rawValue = subdomains.makeRawValue()
    }
    
    public func adding<Other>(other: Other) -> Self where Other: DomainNameProtocol {
        var newSubdomains = subdomains
        newSubdomains.append(contentsOf: other.subdomains)
        
        return ReverseDomainName(subdomains: newSubdomains)
    }
    
    public func adding(subdomain: Subdomain) -> Self {
        var newSubdomains = subdomains
        newSubdomains.append(subdomain)
        
        return Self(subdomains: newSubdomains)
    }
}
