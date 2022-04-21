//
//  ModelV1.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 4/21/22.
//

import CodeMonkeyApple
import XCTest

public struct ModelV1: Codable, Equatable, Storable {
    public let id: UUID
    public let name: String
    
    public static var random: Self {
        ModelV1(id: UUID(), name: UUID().uuidString)
    }
}

// MARK: - Versionable Extension

extension ModelV1: Versionable {
    // TODO: does this make sense? Yikes!
    public typealias Previous = Self
    public typealias Wrapper = ModelWrapper
    
    // MARK: Internal Initialization
    
    public init(from previous: Previous) {
        self = previous
    }
    
    // MARK: Internal Static Interface
    
    public static var version: ModelVersion {
        .v1
    }

    public static func extract(from wrapper: Wrapper) -> Self? {
        switch wrapper {
        case let .v1(model):
            return model
        default:
            return nil
        }
    }
}
