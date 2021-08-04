//
//  AppendValuePreferenceKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/29/21.
//
//  https://finestructure.co/blog/2020/1/20/swiftui-equal-widths-view-constraints

import SwiftUI

public struct AppendValuePreferenceKey<T: Preference> {
    // NO-OP
}

// MARK: - PreferenceKey Extension

extension AppendValuePreferenceKey: PreferenceKey {
    public typealias Value = [CGFloat]
    
    // MARK: Public Static Interface
    
    public static var defaultValue: [CGFloat] {
        []
    }
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}
