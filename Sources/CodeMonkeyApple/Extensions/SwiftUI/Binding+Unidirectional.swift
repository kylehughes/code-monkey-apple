//
//  Binding+Unidirectional.swift
//  Common
//
//  Created by Kyle Hughes on 8/2/21.
//

import SwiftUI

extension Binding where Value: Sendable {
    // MARK: Unidirectional Initialization

    public init(_ constant: Value, set: @escaping @Sendable (Value) -> Void) {
        self.init(get: { constant }, set: set)
    }
}
