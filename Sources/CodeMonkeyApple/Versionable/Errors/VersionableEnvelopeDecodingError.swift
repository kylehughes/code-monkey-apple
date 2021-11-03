//
//  VersionableEnvelopeDecodingError.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/7/21.
//

public enum VersionableEnvelopeDecodingError: Error, Equatable {
    case sourceHasHigherVersionThanDestination(source: UInt, destination: UInt)
    case versionUnknown(UInt)
    
    // MARK: Public Static Interface
    
    public static func sourceHasHigherVersionThanDestination<Version>(
        source: Version,
        destination: Version
    ) -> Self where Version: CodeMonkeyApple.Version {
        .sourceHasHigherVersionThanDestination(source: source.rawValue, destination: destination.rawValue)
    }
}
