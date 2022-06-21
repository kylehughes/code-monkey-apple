//
//  TimeIntervalSelection.swift
//  Common
//
//  Created by Kyle Hughes on 4/16/22.
//

import Foundation

public enum TimeIntervalSelection: Codable, Equatable, Hashable, Storable {
    case builtIn(TimeInterval)
    case custom(TimeInterval)
    
    // MARK: Public Instance Interface
    
    public var isBuiltIn: Bool {
        switch self {
        case .builtIn:
            return true
        case .custom:
            return false
        }
    }
    
    public var isCustom: Bool {
        switch self {
        case .builtIn:
            return false
        case .custom:
            return true
        }
    }
    
    public var value: TimeInterval {
        switch self {
        case let .builtIn(value):
            return value
        case let .custom(value):
            return value
        }
    }
}

// MARK: - Versionable Extension

extension TimeIntervalSelection: Versionable {
    // MARK: Public Typealiases
    
    public typealias Previous = Self
    public typealias Wrapper = TimeIntervalSelectionVersionableWrapper
    
    // MARK: Public Static Interface
    
    public static var version: TimeIntervalSelectionVersion {
        .v1
    }
    
    public static func extract(from wrapper: TimeIntervalSelectionVersionableWrapper) -> Self? {
        switch wrapper {
        case let .v1(value):
            return value
        }
    }
}
