//
//  DispatchQueue+Constants.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/3/21.
//

import Foundation

extension DispatchQueue {
    // MARK: Root Queues
    
    public static let diskIO = DispatchQueueFactory.shared.makeRootQueue(subdomain: "disk-io")
    public static let networkIO = DispatchQueueFactory.shared.makeRootQueue(subdomain: "network-io")
    public static let ui = DispatchQueue.main
    public static let uiWork = DispatchQueueFactory.shared.makeRootQueue(subdomain: "ui-work")
}
