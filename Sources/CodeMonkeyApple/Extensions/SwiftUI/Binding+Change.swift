//
//  Binding+Change.swift
//  Common
//
//  Created by Kyle Hughes on 4/19/22.
//

import SwiftUI

extension Binding where Value: Sendable {
    // MARK: Public Instance Interface

    @MainActor
    public func onChange(_ handler: @escaping @Sendable (Value) async -> Void) -> Binding<Value> {
        onChange { value in
            Task {
                await handler(value)
            }
        }
    }

    public func onChange(_ handler: @escaping @Sendable (Value) -> Void) -> Binding<Value> {
        Binding(
            get: {
                wrappedValue
            },
            set: {
                wrappedValue = $0
                handler($0)
            }
        )
    }
}
