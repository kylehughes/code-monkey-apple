//
//  NSImage+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

extension NSImage {
    // MARK: Public Instance Interface
    
    public func dithering() throws -> NSImage {
        try ImageFilters.Dither.apply(to: self)
    }
}

#endif
