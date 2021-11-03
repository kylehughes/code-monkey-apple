//
//  Versionable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/31/21.
//

public protocol Versionable {
    // MARK: Associated Types
    
    associatedtype Previous: Versionable where Previous.Wrapper == Wrapper
    associatedtype Wrapper: VersionableWrapper
    
    // MARK: Initialization
    
    init(from previous: Previous) throws
    
    // MARK: Static Interface
    
    /// The version of the model.
    static var version: Wrapper.Version { get }
    
    static func extract(from wrapper: Wrapper) -> Self?
}

// MARK: - Bespoke Implementation

extension Versionable {
    // MARK: Public Static Interface
    
    public static func migrate(from wrapper: Wrapper) throws -> Self {
        guard wrapper.version <= version else {
            throw VersionMigrationError.sourceHasHigherVersionThanDestination(source: wrapper, destination: version)
        }
        
        guard let model = extract(from: wrapper) else {
            return try Self(from: Previous.migrate(from: wrapper))
        }
        
        return model
    }
    
    // MARK: Public Instance Interface
    
    public var modelVersion: Wrapper.Version {
        Self.version
    }
}

// MARK: - Convenience Implementation for Earliest Model

extension Versionable where Previous == Self {
    // MARK: Public Initialization
    
    public init(from previous: Previous) {
        self = previous
    }
}
