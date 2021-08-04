//
//  File.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/21/21.
//

// MARK: - Where Element == Subdomain

extension Collection where Element == Subdomain {
    // MARK: Public Instance Interface
    
    public func makeRawValue() -> String {
        map(\.rawValue)
            .joined(separator: ".")
    }
}
