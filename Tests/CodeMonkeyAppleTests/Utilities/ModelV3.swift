//
//  ModelV3.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/21/22.
//

import CodeMonkeyApple
import Foundation

public struct ModelV3: Codable, Equatable, Storable {
    public let id: String
    public let fullName: String
    public let emailAddress: String?
    
    public static var random: Self {
        ModelV3(id: UUID().uuidString, fullName: UUID().uuidString, emailAddress: UUID().uuidString)
    }
}

// MARK: - Versionable Extension

extension ModelV3: Versionable {
    public typealias Previous = ModelV2
    public typealias Wrapper = ModelWrapper
    
    // MARK: Public Initialization
    
    public init(from previous: Previous) throws {
        id = previous.identifier
        fullName = previous.name
        emailAddress = previous.email
    }
    
    // MARK: Public Static Interface
    
    public static var version: ModelVersion {
        .v3
    }
    
    public static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v3(model):
            return model
        default:
            return nil
        }
    }
}
