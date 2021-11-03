//
//  VersionableTests.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 11/3/21.
//

import CodeMonkeyApple
import XCTest

final class VersionableTests: XCTestCase {
    private let decoder = JSONDecoder.default
    private let encoder = JSONEncoder.default
    
    // MARK: XCTestCase Implementation
    
    override func setUp() {
        // NO-OP
    }
    
    override func tearDown() {
        // NO-OP
    }
}

// MARK: - Tests

extension VersionableTests {
    // MARK: Migration Tests
    
    func test_migrate_failure_higherVersion() throws {
        let modelEmail = "test@example.com"
        let modelID = UUID()
        let modelName = "Test"
        
        let modelV2 = ModelV2(identifier: modelID.uuidString, name: modelName, email: modelEmail)
        
        XCTAssertThrowsError(try ModelV1.migrate(from: .v2(modelV2))) { error in
            XCTAssertEqual(
                error as! VersionMigrationError<ModelWrapper>,
                .sourceHasHigherVersionThanDestination(source: ModelV2.version, destination: ModelV1.version)
            )
        }
    }
    
    // MARK: End-to-End Downgrading Tests
    
    func test_e2e_downgrade_failure() throws {
        let modelEmail = "test@example.com"
        let modelID = UUID()
        let modelName = "Test"
        
        let modelV2 = ModelV2(identifier: modelID.uuidString, name: modelName, email: modelEmail)
        let modelV2Envelope = CodableVersionableEnvelope(modelV2)
        let modelV2EnvelopeData = try encoder.encode(modelV2Envelope)
        
        XCTAssertThrowsError(try decoder.decode(CodableVersionableEnvelope<ModelV1>.self, from: modelV2EnvelopeData)) { error in
            XCTAssertEqual(
                error as! VersionableEnvelopeDecodingError,
                .sourceHasHigherVersionThanDestination(source: ModelV2.version, destination: ModelV1.version)
            )
        }
    }
    
    // MARK: End-to-End Upgrading Tests
    
    func test_e2e_upgrade_success_oneVersion() throws {
        let modelEmail = String?.none
        let modelID = UUID()
        let modelName = "Test"
        
        let modelV1 = ModelV1(id: modelID, name: modelName)
        let modelV1Envelope = CodableVersionableEnvelope(modelV1)
        let modelV1EnvelopeData = try encoder.encode(modelV1Envelope)
        
        let expectedModelV2 = ModelV2(identifier: modelID.uuidString, name: modelName, email: modelEmail)
        let migratedModelV2Envelope = try decoder.decode(CodableVersionableEnvelope<ModelV2>.self, from: modelV1EnvelopeData)
        
        XCTAssertEqual(migratedModelV2Envelope.model, expectedModelV2)
        XCTAssertEqual(migratedModelV2Envelope.version, expectedModelV2.modelVersion)
    }
    
    func test_e2e_upgrade_success_sameVersion() throws {
        let modelID = UUID()
        let modelName = "Test"
        
        let modelV1 = ModelV1(id: modelID, name: modelName)
        let modelV1Envelope = CodableVersionableEnvelope(modelV1)
        let modelV1EnvelopeData = try encoder.encode(modelV1Envelope)
        
        let migratedModelV1Envelope = try decoder.decode(CodableVersionableEnvelope<ModelV1>.self, from: modelV1EnvelopeData)
        
        XCTAssertEqual(migratedModelV1Envelope.model, modelV1)
        XCTAssertEqual(migratedModelV1Envelope.version, modelV1.modelVersion)
    }
    
    func test_e2e_upgrade_success_twoVersions() throws {
        let modelEmail = String?.none
        let modelID = UUID()
        let modelName = "Test"
        
        let modelV1 = ModelV1(id: modelID, name: modelName)
        let modelV1Envelope = CodableVersionableEnvelope(modelV1)
        let modelV1EnvelopeData = try encoder.encode(modelV1Envelope)
        
        let expectedModelV3 = ModelV3(id: modelID.uuidString, fullName: modelName, emailAddress: modelEmail)
        let migratedModelV3Envelope = try decoder.decode(CodableVersionableEnvelope<ModelV3>.self, from: modelV1EnvelopeData)
        
        XCTAssertEqual(migratedModelV3Envelope.model, expectedModelV3)
        XCTAssertEqual(migratedModelV3Envelope.version, expectedModelV3.modelVersion)
    }
}

// MARK: - ModelVersion Definition

private enum ModelVersion: UInt, Version {
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

// MARK: - ModelWrapper Definition

private enum ModelWrapper: CodableVersionableWrapper {
    typealias Version = ModelVersion
    
    case v1(ModelV1)
    case v2(ModelV2)
    case v3(ModelV3)
    
    // MARK: Internal Static Inteface
    
    static func deserialize<Key>(
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
    
    // MARK: Internal Instance Interface
    
    var version: Version {
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

// MARK: - ModelV1 Definition

private struct ModelV1: Codable, Equatable {
    let id: UUID
    let name: String
}

// MARK: - Versionable Extension

extension ModelV1: Versionable {
    // TODO: does this make sense? Yikes!
    typealias Previous = Self
    typealias Wrapper = ModelWrapper
    
    // MARK: Internal Initialization
    
    init(from previous: Previous) {
        self = previous
    }
    
    // MARK: Internal Static Interface
    
    static var version: ModelVersion {
        .v1
    }

    static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v1(model):
            return model
        default:
            return nil
        }
    }
}

// MARK: - ModelV2 Definition

private struct ModelV2: Codable, Equatable {
    let identifier: String
    let name: String
    let email: String?
}

// MARK: - Versionable Extension

extension ModelV2: Versionable {
    typealias Previous = ModelV1
    typealias Wrapper = ModelWrapper
    
    // MARK: Internal Initialization
    
    init(from previous: Previous) throws {
        email = nil
        identifier = previous.id.uuidString
        name = previous.name
    }
    
    // MARK: Internal Static Interface
    
    static var version: ModelVersion {
        .v2
    }

    static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v2(model):
            return model
        default:
            return nil
        }
    }
}

// MARK: - ModelV3 Definition

private struct ModelV3: Codable, Equatable {
    let id: String
    let fullName: String
    let emailAddress: String?
}

// MARK: - Versionable Extension

extension ModelV3: Versionable {
    typealias Previous = ModelV2
    typealias Wrapper = ModelWrapper
    
    // MARK: Internal Initialization
    
    init(from previous: Previous) throws {
        id = previous.identifier
        fullName = previous.name
        emailAddress = previous.email
    }
    
    // MARK: Internal Static Interface
    
    static var version: ModelVersion {
        .v3
    }
    
    static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v3(model):
            return model
        default:
            return nil
        }
    }
}
