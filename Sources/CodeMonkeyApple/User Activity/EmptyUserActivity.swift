//
//  EmptyUserActivity.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/23/22.
//

import Foundation

public struct EmptyUserActivity {
    public static let identifier = ReverseDomainName.es_kylehugh_codeMonkey_apple
        .adding(subdomain: "user-activity")
        .adding(subdomain: "empty")
    
    public let id: ReverseDomainName
    public let title: String
    
    // MARK: Public Initialization
    
    public init() {
        id = Self.identifier
        title = String()
    }
}

// MARK: - UserActivity Extension

extension EmptyUserActivity: UserActivity {
    // MARK: Public Initialization
    
    public init?(from platformActivity: NSUserActivity) {
        return nil
    }
    
    // MARK: Public Instance Interface
    
    public func makePlatformActivity() -> NSUserActivity {
        fatalError("Should not be called, this type symbolizes no activity")
    }
    
    public func update(platformActivity: NSUserActivity) {
        // NO-OP
    }
}
