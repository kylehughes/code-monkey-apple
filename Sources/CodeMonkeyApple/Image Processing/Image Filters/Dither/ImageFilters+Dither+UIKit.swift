//
//  DitherImageFilter+UIKit.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

#if canImport(UIKit)

import Accelerate
import UIKit

extension ImageFilters.Dither {
    // MARK: Public Static Interface
    
    public static func apply(to image: UIImage, targetWidth: CGFloat? = nil) throws -> UIImage {     
        UIImage(cgImage: try apply(to: try makeCGImage(from: image), targetWidth: targetWidth))
    }
    
    // MARK: Private Static Interface
    
    private static func makeCGImage(from image: UIImage) throws -> CGImage {
        guard let cgImage = image.cgImage else {
            throw Error.cannotCreateInputCGImage
        }
        
        return cgImage
    }
}

#endif
