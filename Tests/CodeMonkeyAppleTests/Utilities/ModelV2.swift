//
//  ModelV2.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/21/22.
//

import CodeMonkeyApple
import Foundation

public struct ModelV2: Codable, Equatable, Storable {
    public let identifier: String
    public let name: String
    public let email: String?
    
    public static var random: Self {
        ModelV2(identifier: UUID().uuidString, name: UUID().uuidString, email: UUID().uuidString)
    }
}

// MARK: - Versionable Extension

extension ModelV2: Versionable {
    public typealias Previous = ModelV1
    public typealias Wrapper = ModelWrapper
    
    // MARK: Public Initialization
    
    public init(from previous: Previous) throws {
        email = nil
        identifier = previous.id.uuidString
        name = previous.name
    }
    
    // MARK: Public Static Interface
    
    public static var version: ModelVersion {
        .v2
    }

    public static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v2(model):
            return model
        default:
            return nil
        }
    }
}
