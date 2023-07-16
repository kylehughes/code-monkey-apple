//
//  Global+DoOnce.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/15/23.
//

import Foundation

@inlinable
public func doOnce(_ boolean: inout Bool, action: () -> Void) {
    guard !boolean else {
        return
    }
    
    boolean = true
    
    action()
}
