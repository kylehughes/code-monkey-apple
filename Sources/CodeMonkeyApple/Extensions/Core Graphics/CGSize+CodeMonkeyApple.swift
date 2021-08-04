//
//  CGSize+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/28/21.
//

import CoreGraphics

extension CGSize {
    public static let one = CGSize(dimension: 1)
    
    // MARK: Public Initialization
    
    public init(dimension: CGFloat) {
        self.init(width: dimension, height: dimension)
    }
}
