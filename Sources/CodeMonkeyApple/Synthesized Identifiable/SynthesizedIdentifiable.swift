//
//  SynthesizedIdentifiable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/24/21.
//

public protocol SynthesizedIdentifiable: Hashable, Identifiable {
    // NO-OP
}

// MARK: - Implementation

extension SynthesizedIdentifiable {
    // MARK: Public Instance Interface
    
    public var id: Self {
        self
    }
}
