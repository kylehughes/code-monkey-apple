//
//  TimeIntervalSelectionVersionableWrapper.swift
//  Common
//
//  Created by Kyle Hughes on 4/21/22.
//

public enum TimeIntervalSelectionVersionableWrapper {
    case v1(TimeIntervalSelection)
}

// MARK: - VersionableWrapper Extension

extension TimeIntervalSelectionVersionableWrapper: CodableVersionableWrapper {
    // MARK: Public Typealiases
    
    public typealias Version = TimeIntervalSelectionVersion
    
    // MARK: Public Static Interface
    
    public static func deserialize<Key>(
        version: Version,
        from container: KeyedDecodingContainer<Key>,
        at key: Key
    ) throws -> Self where Key: CodingKey {
        switch version {
        case .v1:
            return try .v1(container.decode(TimeIntervalSelection.self, forKey: key))
        }
    }
    
    // MARK: Public Instance Interface
    
    public var version: TimeIntervalSelectionVersion {
        switch self {
        case .v1:
            return .v1
        }
    }
}
