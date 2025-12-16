//
//  StringProtocol+DomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

extension StringProtocol {
    // MARK: Public Instance Interface

    public func makeSubdomains() -> [Subdomain] {
        split(separator: ".")
            .map { String($0) }
            .map { Subdomain(rawValue: $0) }
    }
}
