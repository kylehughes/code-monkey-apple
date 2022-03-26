//
//  GeometryPreferenceReader.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/29/21.
//
//  https://finestructure.co/blog/2020/1/20/swiftui-equal-widths-view-constraints

import SwiftUI

public struct GeometryPreferenceReader<Key: PreferenceKey, Value> where Key.Value == Value {
    public let key: Key.Type
    public let value: (GeometryProxy) -> Value
    
    // MARK: Public Initialization
    
    public init(value: @escaping (GeometryProxy) -> Value) {
        self.value = value
        
        key = Key.self
    }
    
    public init(key: Key.Type, value: @escaping (GeometryProxy) -> Value) {
        self.key = key
        self.value = value
    }
}

// MARK: - ViewModifier Extension

extension GeometryPreferenceReader: ViewModifier {
    // MARK: Public Instance Interface
    
    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader {
                    Color.clear.preference(key: self.key, value: self.value($0))
                }
            )
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func assignMaxPreference<K: PreferenceKey>(
        for key: K.Type,
        to binding: Binding<CGFloat?>
    ) -> some View where K.Value == [CGFloat] {
        onPreferenceChange(key.self) { preferences in
            let maxPreference = preferences.reduce(0, max)
            
            // We only set value if > 0 to avoid pinning sizes to zero.
            guard 0 < maxPreference else {
                return
            }
            
            binding.wrappedValue = maxPreference
        }
    }
    
    public func read<Key, Value>(
        key: Key.Type,
        value: @escaping (GeometryProxy) -> Value
    ) -> some View where Key: PreferenceKey, Key.Value == Value {
        read(GeometryPreferenceReader(key: key, value: value))
    }
    
    public func read<Key, Value>(
        _ preference: GeometryPreferenceReader<Key, Value>
    ) -> some View where Key: PreferenceKey {
        modifier(preference)
    }
}
