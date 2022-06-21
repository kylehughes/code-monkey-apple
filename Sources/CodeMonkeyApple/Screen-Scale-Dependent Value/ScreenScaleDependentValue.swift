//
//  ScreenScaleDependentValue.swift
//  Super Headache
//
//  Created by Kyle Hughes on 4/3/21.
//

#if canImport(UIKit)

import UIKit

@propertyWrapper
public struct ScreenScaleDependentValue<Value> {
    public let wrappedValue: Value
    
    // MARK: Public Initialization
    
    public init(
        pixels: @autoclosure () -> Value
    ) where Value: BinaryFloatingPoint {
        wrappedValue = pixels() / Value(UIScreen.main.scale)
    }
    
    public init(
        x: @autoclosure () -> Value,
        xx: @autoclosure () -> Value,
        xxx: @autoclosure () -> Value
    ) {
        switch UIScreen.main.scale {
        case 1:
            wrappedValue = x()
        case 2:
            wrappedValue = xx()
        case 3:
            wrappedValue = xxx()
        default:
            wrappedValue = x()
        }
    }
}

#endif
