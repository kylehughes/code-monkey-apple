//
//  CGRect+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/28/21.
//

import CoreGraphics

extension CGRect {
    // MARK: Public Instance Interface
    
    public var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
