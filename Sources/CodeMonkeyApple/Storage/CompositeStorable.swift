//
//  CompositeStorable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

public protocol CompositeStorable: Storable where StorableValue == Components {
    // MARK: Associated Types
    
    associatedtype Components: Storable
    
    // MARK: Static Interface
    
    static func compose(from components: Components) -> Self
}

// MARK: - Storable Implementation

extension CompositeStorable {
    // MARK: Public Static Interface
    
    public static func decode(from storage: @autoclosure () -> Components?) -> Self? {
        guard let components = storage() else {
            return nil
        }
        
        return compose(from: components)
    }
}
