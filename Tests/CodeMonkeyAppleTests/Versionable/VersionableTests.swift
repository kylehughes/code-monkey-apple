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
