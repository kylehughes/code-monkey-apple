//
//  Color+Equality.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/11/22.
//

#if canImport(UIKit)
import SwiftUI
import UIKit

extension Color {
    // MARK: Public Instance Interface
    
    public func rgbaEqualsRGBA(from rhs: Color) -> Bool {
        UIColor(self).rgbaEqualsRGBA(from: UIColor(rhs))
    }
}
#endif
