//
//  UserActivity.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/22/21.
//

import Foundation

public protocol UserActivity: Identifiable {
    // MARK: Initialization
    
    init?(from platformActivity: NSUserActivity)
    
    // MARK: Instance Inteface
    
    var id: ReverseDomainName { get }
    var title: String { get }
    
    func makePlatformActivity() -> NSUserActivity
    func update(platformActivity: NSUserActivity)
}

// MARK: - Implementation

extension UserActivity {
    // MARK: Public Instance Interface
    
    public func becomeCurrent() {
        makePlatformActivity().becomeCurrent()
    }
    
    public func resignCurrent() {
        makePlatformActivity().becomeCurrent()
    }
}
