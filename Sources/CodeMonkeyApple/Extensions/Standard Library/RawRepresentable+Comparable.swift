//
//  RawRepresentable+Comparable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/3/21.
//

extension RawRepresentable where RawValue: Comparable {
    // MARK: Public Static Interface
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
