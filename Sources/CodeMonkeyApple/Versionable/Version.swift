//
//  Version.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/31/21.
//

public protocol Version:
    CaseIterable,
    Comparable,
    Codable,
    RawRepresentable,
    SynthesizedIdentifiable
where
    RawValue == UInt
{
    // NO-OP
}
