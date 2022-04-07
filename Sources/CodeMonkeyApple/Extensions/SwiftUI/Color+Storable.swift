//
//  Color+Storable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/7/22.
//

import SwiftUI

extension Color: Storable {
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> String?) -> Color? {
        guard let string = storage(), let data = string.data(using: .utf8) else {
            return nil
        }
        
        return try? JSONDecoder.default.decode(Color.self, from: data)
    }
    
    // MARK: Public Instance Interface
    
    public func encodeForStorage() -> String {
        guard let string = try? String(data: JSONEncoder.default.encode(self), encoding: .utf8) else {
            return String()
        }
        
        return string
    }
}
