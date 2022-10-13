//
//  View+Conditional.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/13/22.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    /// - Warning: This should only be used to conditionally apply modifiers that require protocols, e.g.
    /// `ButtonStyle` or `ShapeStyle`. Otherwise, ternary operators at the callsite are preferred. If the condition
    /// changes for the same view then the transition animation may be incorrect.
    @ViewBuilder
    public func `if`(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder then: (Self) -> some View,
        @ViewBuilder else: (Self) -> some View
    ) -> some View {
        if condition() {
            then(self)
        } else {
            `else`(self)
        }
    }
}
