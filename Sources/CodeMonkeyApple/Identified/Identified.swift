//
//  Identified.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/12/22.
//

import Foundation

public struct Identified<Value>: Identifiable {
    public let id: UUID
    
    public var value: Value
    
    // MARK: Public Initialization
    
    public init(_ value: Value) {
        self.value = value
        
        id = UUID()
    }
    
    public init(id: UUID, value: Value) {
        self.id = id
        self.value = value
    }
}
