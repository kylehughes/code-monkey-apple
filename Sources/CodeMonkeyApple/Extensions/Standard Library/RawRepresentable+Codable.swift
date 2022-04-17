//
//  RawRepresentable+Codable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/16/22.
//

import Foundation

extension RawRepresentable where Self: Codable, RawValue == String {
    // MARK: Public Initialization
    
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let color = try? JSONDecoder.default.decode(Self.self, from: data)
        else {
            return nil
        }
        
        self = color
    }
    
    // MARK: Public Instance Interface
    
    public var rawValue: String {
        try! String(data: JSONEncoder.default.encode(self), encoding: .utf8)!
    }
}
