//
//  UIActivityViewController+CodeMonkeyApple.swift
//  Rank Things
//
//  Created by Kyle Hughes on 7/1/21.
//

#if canImport(UIKit)

import UIKit

extension UIActivityViewController {
    // MARK: Public Initialization
    
    public convenience init(activityItem: Any) {
        self.init(activityItems: [activityItem])
    }
    
    public convenience init(activityItems: [Any]) {
        self.init(activityItems: activityItems, applicationActivities: nil)
    }
}

#endif
