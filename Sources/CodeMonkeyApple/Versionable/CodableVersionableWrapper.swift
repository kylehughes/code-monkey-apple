//
//  CodableVersionWrapper.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/7/21.
//

public protocol CodableVersionableWrapper: VersionableWrapper {
    // MARK: Static Interface
    
    static func deserialize<Key>(
        version: Version,
        from container: KeyedDecodingContainer<Key>,
        at key: Key
    ) throws -> Self
}
