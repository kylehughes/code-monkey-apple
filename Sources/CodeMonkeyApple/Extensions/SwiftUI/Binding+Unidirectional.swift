//
//  Binding+Unidirectional.swift
//  Common
//
//  Created by Kyle Hughes on 8/2/21.
//

import SwiftUI

extension Binding {
    // MARK: Unidirectional Initialization
    
    public init(_ constant: Value, set: @escaping (Value) -> Void) {
        self.init(get: { constant }, set: set)
    }
}
