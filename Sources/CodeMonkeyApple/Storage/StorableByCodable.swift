//
//  StorableByCodable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/16/22.
//

import Foundation

public protocol StorableByCodable: Storable where Self: Codable {
    // NO-OP
}

// MARK: - Codable Extension

extension StorableByCodable {
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> String?) -> Self? {
        guard
            let jsonString = storage(),
            let json = jsonString.data(using: .utf8),
            let value = try? JSONDecoder.default.decode(Self.self, from: json)
        else {
            return nil
        }
        
        return value
    }

    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> String {
        String(data: try! JSONEncoder.default.encode(self), encoding: .utf8)!
    }
}
