//
//  NSSet+Bridge.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/30/21.
//

import Foundation

extension NSSet {
    // MARK: Public Instance Interface
    
    public func typed<Element>() -> Set<Element> {
        typed(as: Element.self)
    }
    
    public func typed<Element>(as type: Element.Type) -> Set<Element> {
        guard let set = self as? Set<Element> else {
            return Set()
        }
        
        return set
    }
}
