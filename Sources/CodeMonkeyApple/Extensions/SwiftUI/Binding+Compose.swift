//
//  Binding+Compose.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/19/22.
//

import SwiftUI

extension Binding {
    // MARK: Public Instance Interface
    
    public func composedToBool<Unwrapped>(
        whenEqualTo value: Value
    ) -> Binding<Bool> where Value == Unwrapped?, Unwrapped: Equatable {
        Binding<Bool> {
            wrappedValue == value
        } set: {
            wrappedValue = $0 ? value : nil
        }
    }
    
    public func composed<Other>(through keyPath: WritableKeyPath<Value, Other>) -> Binding<Other> {
        Binding<Other> {
            wrappedValue[keyPath: keyPath]
        } set: {
            wrappedValue[keyPath: keyPath] = $0
        }
    }
    
    public func composed<Other>(to: @escaping (Value) -> Other, from: @escaping (Other) -> Value) -> Binding<Other> {
        Binding<Other> {
            to(wrappedValue)
        } set: {
            wrappedValue = from($0)
        }
    }
}
