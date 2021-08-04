//
//  UIViewController+CodeMonkeyApple.swift
//  Rank Things
//
//  Created by Kyle Hughes on 6/12/21.
//

#if canImport(UIKit)

import UIKit

extension UIViewController {
    // MARK: Public Instance Interface
    
    public var viewControllerToPresentOn: UIViewController {
        presentedViewController?.viewControllerToPresentOn ?? self
    }
}

#endif
