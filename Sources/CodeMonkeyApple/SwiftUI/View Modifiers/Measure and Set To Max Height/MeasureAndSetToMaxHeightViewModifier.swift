//
//  MeasureAndSetToMaxHeightViewModifier.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/14/23.
//

import SwiftUI

public struct MeasureAndSetToMaxHeightViewModifier {
    @Binding private var value: CGFloat?
    
    // MARK: Public Initialization
    
    public init(value: Binding<CGFloat?>) {
        _value = value
    }
}

// MARK: - ViewModifier Extension

extension MeasureAndSetToMaxHeightViewModifier: ViewModifier {
    // MARK: Getting the Body
    
    public func body(content: Content) -> some View {
        content
            .read(key: MaxValuePreferenceKey<CGFloat>.self) {
                $0.size.height
            }
            .onPreferenceChange(MaxValuePreferenceKey<CGFloat>.self) {
                value = $0
            }
            .frame(height: value)
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    @inlinable
    func measureAndSetToMaxHeight(storedIn storage: Binding<CGFloat?>) -> some View {
        modifier(MeasureAndSetToMaxHeightViewModifier(value: storage))
    }
}


