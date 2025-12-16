//
//  Button+Concurrency.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/11/21.
//

import SwiftUI

extension Button {
    // MARK: Creating a Button

    @MainActor
    public init(asyncAction: @escaping @Sendable () async -> Void, label: () -> Label) {
        self.init(
            action: {
                Task {
                    await asyncAction()
                }
            },
            label: label
        )
    }

    @MainActor
    public init(_ titleKey: LocalizedStringKey, asyncAction: @escaping @Sendable () async -> Void) where Label == Text {
        self.init(
            titleKey,
            action: {
                Task {
                    await asyncAction()
                }
            }
        )
    }

    @MainActor
    public init<S>(_ title: S, asyncAction: @escaping @Sendable () async -> Void) where Label == Text, S: StringProtocol {
        self.init(
            title,
            action: {
                Task {
                    await asyncAction()
                }
            }
        )
    }

    // MARK: Creating a Button with a Role

    @MainActor
    public init(role: ButtonRole?, asyncAction: @escaping @Sendable () async -> Void, label: () -> Label) {
        self.init(
            role: role,
            action: {
                Task {
                    await asyncAction()
                }
            },
            label: label
        )
    }

    @MainActor
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole?,
        asyncAction: @escaping @Sendable () async -> Void
    ) where Label == Text {
        self.init(
            titleKey,
            role: role,
            action: {
                Task {
                    await asyncAction()
                }
            }
        )
    }

    @MainActor
    public init<S>(
        _ title: S,
        role: ButtonRole?,
        asyncAction: @escaping @Sendable () async -> Void
    ) where Text == Label, S: StringProtocol {
        self.init(
            title,
            role: role,
            action: {
                Task {
                    await asyncAction()
                }
            }
        )
    }
}
