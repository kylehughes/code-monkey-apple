//
//  View+Concurrency.swift
//  Common
//
//  Created by Kyle Hughes on 3/28/22.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface

    @MainActor
    public func onChange<Value>(
        of value: Value,
        perform action: @escaping @Sendable (Value) async -> Void
    ) -> some View where Value: Equatable & Sendable {
        onChange(of: value) { oldValue, newValue in
            Task {
                await action(newValue)
            }
        }
    }

    @MainActor
    public func onTapGesture(count: Int = 1, perform action: @escaping @Sendable () async -> Void) -> some View {
        onTapGesture(count: count) {
            Task {
                await action()
            }
        }
    }
}
