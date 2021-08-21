//
//  BuildDependentValue.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/20/21.
//

@propertyWrapper
public struct BuildDependentValue<Value> {
    public let wrappedValue: Value
    
    // MARK: Public Initialization

    public init(
        debug: Value,
        release: Value
    ) {
        #if DEBUG
        wrappedValue = debug
        #else
        wrappedValue = release
        #endif
    }
}
