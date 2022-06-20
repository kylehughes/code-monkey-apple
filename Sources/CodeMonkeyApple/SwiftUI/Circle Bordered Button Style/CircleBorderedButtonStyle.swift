//
//  CircleBorderedButtonStyle.swift
//  SuperHeadache
//
//  Created by Kyle Hughes on 3/22/22.
//

import SwiftUI

public struct CircleBorderedButtonStyle {
    // NO-OP
}

// MARK: - ButtonStyle Extension

extension CircleBorderedButtonStyle: ButtonStyle {
    // MARK: Public Instance Interface
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.tint)
            .padding(8)
            .background(
                Circle()
                    .fill(.tint)
                    .opacity(UIConstants.borderedStyleBackgroundOpacity)
            )
            .opacity(configuration.isPressed ? UIConstants.borderedStylePressedOpacity : 1.0)
    }
}

// MARK: - Extension for ButtonStyle

extension ButtonStyle where Self == CircleBorderedButtonStyle {
    // MARK: Public Static Interface
    
    public static var circleBordered: CircleBorderedButtonStyle {
        CircleBorderedButtonStyle()
    }
}
