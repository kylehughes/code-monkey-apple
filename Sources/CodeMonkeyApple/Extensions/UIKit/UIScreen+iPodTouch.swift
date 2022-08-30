//
//  UIScreen+iPodTouch.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/12/22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UIScreen {
    // MARK: Internal Instance Interface
    
    public var hasiPodTouchScreenSize: Bool {
        bounds == CGRect(x: 0, y: 0, width: 320, height: 568)
    }
}

#endif
