//
//  String+EnumCase.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/1/22.
//

#if DEBUG
@_silgen_name("swift_EnumCaseName")
internal func _getEnumCaseName<T>(_ value: T) -> UnsafePointer<CChar>?

public func getEnumCaseName<T>(for value: T) -> String? {
    guard let stringPtr = _getEnumCaseName(value) else {
        return nil
    }
    
    return String(validatingUTF8: stringPtr)
}
#endif
