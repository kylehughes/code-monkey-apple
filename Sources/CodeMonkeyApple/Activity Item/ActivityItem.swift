//
//  ActivityItem.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/15/21.
//

import Foundation

public protocol ActivityItem: Equatable {
    /// The object that will be passed to the `UIActivityViewController`.
    var platformActivityItem: Any { get }
}

// MARK: - Extension for URL

extension URL: ActivityItem {
    // MARK: Internal Instance Interface
    
    public var platformActivityItem: Any {
        self
    }
}
