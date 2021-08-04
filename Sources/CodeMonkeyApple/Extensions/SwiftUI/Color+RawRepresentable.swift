//
//  Color+RawRepresentable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/4/21.
//

import SwiftUI

extension Color: RawRepresentable {
    // MARK: Public Initialization
    
    public init?(rawValue: String) {
        guard
            let data = rawValue.data(using: .utf8),
            let color = try? JSONDecoder.default.decode(Color.self, from: data)
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
