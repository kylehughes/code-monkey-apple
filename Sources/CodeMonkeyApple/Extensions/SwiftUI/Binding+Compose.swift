//
//  Binding+Compose.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/19/22.
//

import SwiftUI

extension Binding where Value: Sendable {
    // MARK: Public Instance Interface

    public func composedToBool<Unwrapped>(
        whenEqualTo value: Value
    ) -> Binding<Bool> where Value == Unwrapped?, Unwrapped: Equatable & Sendable {
        let binding = self
        let value = value
        return Binding<Bool> {
            binding.wrappedValue == value
        } set: { newValue in
            binding.wrappedValue = newValue ? value : nil
        }
    }

    public func composed<Other: Sendable>(through keyPath: WritableKeyPath<Value, Other> & Sendable) -> Binding<Other> {
        let binding = self
        let keyPath = keyPath
        return Binding<Other> {
            binding.wrappedValue[keyPath: keyPath]
        } set: { newValue in
            binding.wrappedValue[keyPath: keyPath] = newValue
        }
    }

    public func composed<Other: Sendable>(
        to: @escaping @Sendable (Value) -> Other,
        from: @escaping @Sendable (Other) -> Value
    ) -> Binding<Other> {
        let binding = self
        return Binding<Other> {
            to(binding.wrappedValue)
        } set: { newValue in
            binding.wrappedValue = from(newValue)
        }
    }
}
