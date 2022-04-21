//
//  ModelWrapper.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/21/22.
//

import CodeMonkeyApple

public enum ModelWrapper: CodableVersionableWrapper {
    public typealias Version = ModelVersion
    
    case v1(ModelV1)
    case v2(ModelV2)
    case v3(ModelV3)
    
    // MARK: Public Static Inteface
    
    public static func deserialize<Key>(
        version: Version,
        from container: KeyedDecodingContainer<Key>,
        at key: Key
    ) throws -> Self {
        switch version {
        case .v1:
            return try .v1(container.decode(ModelV1.self, forKey: key))
        case .v2:
            return try .v2(container.decode(ModelV2.self, forKey: key))
        case .v3:
            return try .v3(container.decode(ModelV3.self, forKey: key))
        }
    }
    
    // MARK: Public Instance Interface
    
    public var version: Version {
        switch self {
        case .v1:
            return .v1
        case .v2:
            return .v2
        case .v3:
            return .v3
        }
    }
}
