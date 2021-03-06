//
//  CGImage+CodeMonkeyApple.swift
//  code-monkey-apple
//
//  Created by Kyle Hughes on 3/6/21.
//

import CoreGraphics

extension CGImage {
    // MARK: Public Instance Interface
    
    public var hasAlphaChannel: Bool {
        alphaInfo == .none || alphaInfo == .noneSkipFirst || alphaInfo == .noneSkipLast
    }
}
