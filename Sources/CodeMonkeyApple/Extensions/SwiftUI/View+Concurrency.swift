//
//  View+Concurrency.swift
//  Common
//
//  Created by Kyle Hughes on 3/28/22.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    public func onChange<Value>(
        of value: Value,
        perform action: @escaping (Value) async -> Void
    ) -> some View where Value : Equatable {
        onChange(of: value) { newValue in
            Task {
                await action(newValue)
            }
        }
    }
    
    public func onTapGesture(count: Int = 1, perform action: @escaping () async -> Void) -> some View {
        onTapGesture(count: count) {
            Task {
                await action()
            }
        }
    }
}
