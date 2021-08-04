//
//  Color+RankThings.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/4/21.
//

import SwiftUI

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

// MARK: - Decodable Extension

extension Color: Decodable {
    // MARK: Public Instance Interface
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Encodable Extension

extension Color: Encodable {
    // MARK: Public Instance Interface
    
    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
    
    // MARK: Private Instance Interface
    
    private var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        NSColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc
        // exception.
        #else
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

// MARK: - Color.CodingKeys Definition

extension Color {
    public enum CodingKeys: String, CodingKey {
        case red
        case green
        case blue
    }
}
