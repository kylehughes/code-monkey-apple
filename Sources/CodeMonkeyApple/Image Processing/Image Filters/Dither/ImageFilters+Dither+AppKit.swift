//
//  ImageFilters+Dither+AppKit.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import Accelerate
import AppKit

extension ImageFilters.Dither {
    // MARK: Public Static Interface
    
    public static func apply(to image: NSImage, targetWidth: CGFloat? = nil) throws -> NSImage {
        NSImage(cgImage: try apply(to: try makeCGImage(from: image), targetWidth: targetWidth), size: NSZeroSize)
    }
    
    // MARK: Private Static Interface
    
    private static func makeCGImage(from image: NSImage) throws -> CGImage {
        guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            throw Error.cannotCreateInputCGImage
        }
        
        return cgImage
    }
}

#endif
