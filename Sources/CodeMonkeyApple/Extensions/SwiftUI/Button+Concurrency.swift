//
//  Button+Concurrency.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/11/21.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
extension Button {
    // MARK: Creating a Button
    
    public init(asyncAction: @escaping () async -> Void, label: () -> Label) {
        self.init(
            action: {
                Task {
                    await asyncAction()
                }
            },
            label: label
        )
    }
    
    public init(_ titleKey: LocalizedStringKey, asyncAction: @escaping () async -> Void) where Label == Text {
        self.init(
            titleKey,
            action: {
                Task {
                    await asyncAction()
                }
            }
        )
    }
    
    public init<S>(_ title: S, asyncAction: @escaping () async -> Void) where Label == Text, S: StringProtocol {
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
    
    public init(role: ButtonRole?, asyncAction: @escaping () async -> Void, label: () -> Label) {
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
    
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole?,
        asyncAction: @escaping () async -> Void
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
    
    public init<S>(
        _ title: S,
        role: ButtonRole?,
        asyncAction: @escaping () async -> Void
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
