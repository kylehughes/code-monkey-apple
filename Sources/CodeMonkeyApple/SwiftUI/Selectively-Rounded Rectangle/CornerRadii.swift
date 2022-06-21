//
//  CornerRadii.swift
//  Common
//
//  Created by Kyle Hughes on 4/12/22.
//

import Accelerate
import CoreGraphics
import SwiftUI

public struct CornerRadii: Equatable {
    public private(set) var bottomLeft: CGFloat
    public private(set) var bottomRight: CGFloat
    public private(set) var topLeft: CGFloat
    public private(set) var topRight: CGFloat
    
    // MARK: Internal Intialization
    
    public init(_ all: CGFloat) {
        self.init(topLeft: all, topRight: all, bottomLeft: all, bottomRight: all)
    }
    
    public init(
        top: CGFloat,
        bottom: CGFloat
    ) {
        self.init(topLeft: top, topRight: top, bottomLeft: bottom, bottomRight: bottom)
    }
    
    public init(
        left: CGFloat,
        right: CGFloat
    ) {
        self.init(topLeft: left, topRight: right, bottomLeft: left, bottomRight: right)
    }
    
    public init(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomLeft: CGFloat,
        bottomRight: CGFloat
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
}

// MARK: - AdditiveArithmetic Extension

extension CornerRadii {
    // MARK: Convenience
    
    public static var zero: Self {
        Self(0)
    }
    
    // MARK: Operator Functions
    
    public static func + (lhs: Self, rhs: Self) -> Self {
        CornerRadii(
            topLeft: lhs.topLeft + rhs.topLeft,
            topRight: lhs.topRight + rhs.topRight,
            bottomLeft: lhs.bottomLeft + rhs.bottomLeft,
            bottomRight: lhs.bottomRight + rhs.bottomRight
        )
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.bottomLeft += rhs.bottomLeft
        lhs.bottomRight += rhs.bottomRight
        lhs.topLeft += rhs.topLeft
        lhs.topRight += rhs.topRight
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        CornerRadii(
            topLeft: lhs.topLeft - rhs.topLeft,
            topRight: lhs.topRight - rhs.topRight,
            bottomLeft: lhs.bottomLeft - rhs.bottomLeft,
            bottomRight: lhs.bottomRight - rhs.bottomRight
        )
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.bottomLeft -= rhs.bottomLeft
        lhs.bottomRight -= rhs.bottomRight
        lhs.topLeft -= rhs.topLeft
        lhs.topRight -= rhs.topRight
    }
}

// MARK: - VectorArithmetic Extension

extension CornerRadii: VectorArithmetic {
    // MARK: Manipulating Values
    
    public mutating func scale(by rhs: Double) {
        bottomLeft.scale(by: rhs)
        bottomRight.scale(by: rhs)
        topLeft.scale(by: rhs)
        topRight.scale(by: rhs)
    }
    
    public var magnitudeSquared: Double {
        bottomLeft * bottomLeft +
        bottomRight * bottomRight +
        topLeft * topLeft +
        topRight * topRight
    }
}
