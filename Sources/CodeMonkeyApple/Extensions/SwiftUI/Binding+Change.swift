//
//  Binding+Change.swift
//  Common
//
//  Created by Kyle Hughes on 4/19/22.
//

import SwiftUI

extension Binding {
    // MARK: Public Instance Interface
    
    public func onChange(_ handler: @escaping (Value) async -> Void) -> Binding<Value> {
        onChange { value in
            Task {
                await handler(value)
            }
        }
    }
    
    public func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
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
