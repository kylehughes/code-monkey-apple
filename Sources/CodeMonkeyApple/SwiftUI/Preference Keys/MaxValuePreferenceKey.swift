//
//  MaxValuePreferenceKey.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/14/23.
//

import SwiftUI

public struct MaxValuePreferenceKey<WrappedValue> where WrappedValue: Comparable {
    // NO-OP
}

// MARK: - PreferenceKey Extension

extension MaxValuePreferenceKey: PreferenceKey {
    // MARK: Getting the Default Value
    
    public typealias Value = Optional<WrappedValue>
    
    // MARK: Combining Preferences
    
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        switch (value, nextValue()) {
        case let (.some(original), .some(next)):
            value = max(original, next)
        case (.some, .none):
            break
        case let (.none, .some(next)):
            value = next
        case (.none, .none):
            break
        }
    }
}
