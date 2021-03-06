//
//  UIImage+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

#if canImport(UIKit)

import UIKit

extension UIImage {
    // MARK: Public Instance Interface

    public func dithering() throws -> UIImage {
        try ImageFilters.Dither.apply(to: self)
    }
}

#endif
