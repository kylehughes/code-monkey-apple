//
//  ModelVersion.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/21/22.
//

import CodeMonkeyApple

public enum ModelVersion: UInt, Version {
    case v1 = 1
    case v2 = 2
    case v3 = 3
}

// MARK: - Comparable Extension

extension Comparable where Self: RawRepresentable, RawValue == Int {
    // MARK: Public Static Interface
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
