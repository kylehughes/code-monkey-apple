//
//  StringProtocol+DomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

extension StringProtocol {
    // MARK: Public Instance Interface
    
    public func makeSubdomains() -> [Subdomain] {
        lazy
            .split(separator: ".")
            .map(String.init)
            .map(Subdomain.init(rawValue:))
    }
}
