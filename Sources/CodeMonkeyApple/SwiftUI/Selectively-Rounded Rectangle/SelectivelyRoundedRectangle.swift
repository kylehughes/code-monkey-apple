//
//  RoundedRectangle+Super Headache.swift
//  Super Headache
//
//  Created by Kyle Hughes on 3/27/21.
//

import SwiftUI

public struct SelectivelyRoundedRectangle {
    public var animatableData: CornerRadii
    
    // MARK: Internal Intialization
    
    public init(radii: CornerRadii) {
        animatableData = radii
    }
}

// MARK: - Shape Extension

extension SelectivelyRoundedRectangle: Shape {
    // MARK: Internal Instance Interface
    
    public func path(in rect: CGRect) -> Path {
        .continuouslyRoundedRectangle(in: rect, with: animatableData)
    }
}
