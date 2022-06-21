//
//  Thread+Number.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/30/22.
//

import Foundation

extension Thread {
    // MARK: Public Static Interface
    
    public static var number: Int {
        current.number
    }
    
    // MARK: Public Instance Interface
    
    public var number: Int {
        let originalString = String(describing: self)
        let regex = NSRegularExpression(#".+= (\d+)"#)
        
        guard
            let match = regex.firstMatch(in: originalString),
            let range = Range(match.range(at: 1), in: originalString),
            let integer = Int(originalString[range])
        else {
            return -1
        }
        
        return integer
    }
}
