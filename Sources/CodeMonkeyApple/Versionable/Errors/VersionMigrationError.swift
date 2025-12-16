//
//  VersionMigrationError.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/7/21.
//

public enum VersionMigrationError<Wrapper>:
    Error,
    Equatable,
    Sendable
where
    Wrapper: CodeMonkeyApple.VersionableWrapper,
    Wrapper.Version: Sendable
{
    case ineligibleForMigration(source: Wrapper.Version, destination: Wrapper.Version)
    case sourceHasHigherVersionThanDestination(source: Wrapper.Version, destination: Wrapper.Version)
    
    // MARK: Public Static Interface
    
    public static func ineligibleForMigration(
        source: Wrapper,
        destination: Wrapper.Version
    ) -> Self {
        .ineligibleForMigration(source: source.version, destination: destination)
    }
    
    public static func ineligibleForMigration(
        source: Wrapper.Version,
        destination: Wrapper
    ) -> Self {
        .ineligibleForMigration(source: source, destination: destination.version)
    }
    
    public static func ineligibleForMigration(
        source: Wrapper,
        destination: Wrapper
    ) -> Self {
        .ineligibleForMigration(source: source.version, destination: destination.version)
    }
    
    public static func sourceHasHigherVersionThanDestination(
        source: Wrapper,
        destination: Wrapper.Version
    ) -> Self {
        .sourceHasHigherVersionThanDestination(source: source.version, destination: destination)
    }
    
    public static func sourceHasHigherVersionThanDestination(
        source: Wrapper.Version,
        destination: Wrapper
    ) -> Self {
        .sourceHasHigherVersionThanDestination(source: source, destination: destination.version)
    }
    
    public static func sourceHasHigherVersionThanDestination(
        source: Wrapper,
        destination: Wrapper
    ) -> Self {
        .sourceHasHigherVersionThanDestination(source: source.version, destination: destination.version)
    }
}
