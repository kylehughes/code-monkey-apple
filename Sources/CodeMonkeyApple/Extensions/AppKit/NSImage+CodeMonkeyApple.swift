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
    
    public var hasAlphaChannel: Bool {
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return false
        }
        
        return cgImage.hasAlphaChannel
    }
    
    public func dithering() throws -> NSImage {
        try ImageFilters.Dither.apply(to: self)
    }
}

#endif
