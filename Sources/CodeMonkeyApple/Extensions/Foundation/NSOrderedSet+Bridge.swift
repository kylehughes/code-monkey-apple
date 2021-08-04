//
//  NSOrderedSet+Bridge.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/26/21.
//

import Foundation

extension NSOrderedSet {
    // MARK: Public Instance Interface
    
    public func typed<Element>() -> [Element] {
        typed(as: Element.self)
    }
    
    public func typed<Element>(as type: Element.Type) -> [Element] {
        guard let array = array as? [Element] else {
            return []
        }
        
        return array
    }
}
