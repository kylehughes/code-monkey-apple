//
//  ReverseDomainName.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

public typealias ReverseDomainName = DomainName

// MARK: - Constants

extension ReverseDomainName {
    public static let es_kylehugh = es.adding(subdomain: "kylehugh")
    public static let es_kylehugh_codeMonkey = es_kylehugh.adding(subdomain: "code-monkey")
    public static let es_kylehugh_codeMonkey_apple = es_kylehugh_codeMonkey.adding(subdomain: "apple")
}
