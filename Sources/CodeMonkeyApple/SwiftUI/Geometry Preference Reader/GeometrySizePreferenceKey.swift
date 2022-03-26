//
//  GeometrySizePreferenceKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/26/22.
//

import SwiftUI

public struct GeometrySizePreferenceKey {
    // Private Initialization
    
    private init() {
        // NO-OP
    }
}

// MARK: - PreferenceKey Extension

extension GeometrySizePreferenceKey: PreferenceKey {
    // MARK: Public Instance Interface
    
    public static var defaultValue: CGSize {
        .zero
    }
    
    // MARK: Combining Preferences
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value = CGSize(
            width: value.width + nextValue().width,
            height: value.height + nextValue().height
        )
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func onSizeChange(perform handler: @escaping (CGSize) -> Void) -> some View {
        read(key: GeometrySizePreferenceKey.self) {
            $0.frame(in: .local).size
        }
        .onPreferenceChange(GeometrySizePreferenceKey.self, perform: handler)
    }
}
