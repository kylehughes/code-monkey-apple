//
//  CodableVersionableEnvelope.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/2/21.
//

/// A type that automatically encodes and decodes a `Versionable` body. It is the one-stop-shop for persisting `Codable`
/// models to disk.
///
/// Migration to the model version happens automatically if the type being decoded is of an earlier version.
///
/// The recommended practice is to keep all of the model versions that have ever shipped with the software. Always
/// encode and decode the latest model version.
public struct CodableVersionableEnvelope<Model>:
    Encodable
where
    Model: Codable & Versionable,
    Model.Wrapper: CodableVersionableWrapper
{
    public let model: Model
    public let version: Model.Wrapper.Version
    
    // MARK: Public Initialization
    
    public init(_ body: Model) {
        self.model = body
        
        version = Model.version
    }
}

// MARK: - Decodable Extension

extension CodableVersionableEnvelope: Decodable {
    // MARK: Public Initialization
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodedVersionRawValue = try container.decode(Model.Wrapper.Version.RawValue.self, forKey: .version)
        
        guard decodedVersionRawValue <= Model.version.rawValue else {
            throw VersionableEnvelopeDecodingError.sourceHasHigherVersionThanDestination(
                source: decodedVersionRawValue,
                destination: Model.version.rawValue
            )
        }
        
        guard let decodedVersion = Model.Wrapper.Version(rawValue: decodedVersionRawValue) else {
            throw VersionableEnvelopeDecodingError.versionUnknown(decodedVersionRawValue)
        }
        
        model = try Model.migrate(
            from: Model.Wrapper.deserialize(version: decodedVersion, from: container, at: .model)
        )
        version = Model.version
    }
}

// MARK: - CodingKeys Definition

extension CodableVersionableEnvelope {
    public enum CodingKeys: String, CodingKey {
        case model = "model"
        case version = "version"
    }
}
