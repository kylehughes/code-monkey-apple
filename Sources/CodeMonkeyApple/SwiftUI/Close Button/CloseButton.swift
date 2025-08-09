//
//  CloseButton.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/29/22.
//

#if !os(macOS) && !os(watchOS)

import SwiftUI

public struct CloseButton {
    // MARK: Internal Properties
    
    @usableFromInline
    let action: () -> Void

    // MARK: Public Initialization
    
    @inlinable
    public init(action: @escaping () -> Void) {
        self.action = action
    }
}

// MARK: - UIViewRepresentable Extension

extension CloseButton: UIViewRepresentable {
    // MARK: Public Instance Interface
    
    @inlinable
    public func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }

    @inlinable
    public func makeUIView(context: Context) -> UIButton {
        let view = UIButton(type: .close)
        
        view.addTarget(context.coordinator, action: #selector(Coordinator.perform), for: .primaryActionTriggered)

        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)

        return view
    }

    @inlinable
    public func updateUIView(_ uiView: UIButton, context: Context) {
        context.coordinator.action = action
    }
}

// MARK: - Coordinator Definition

extension CloseButton {
    public final class Coordinator {
        @usableFromInline
        var action: () -> Void

        @usableFromInline
        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc
        @usableFromInline
        func perform() {
            action()
        }
    }
}

// MARK: - Extension for ToolbarItem

extension ToolbarItem<(), CloseButton> {
    // MARK: Public Static Interface

    @inlinable
    public static func closeButton(
        isTrailing: Bool = true,
        using dismiss: DismissAction
    ) -> Self {
        ToolbarItem(placement: isTrailing ? .navigationBarTrailing : .navigationBarLeading) {
            CloseButton {
                #if canImport(UIKit) && !os(watchOS)
                HapticFeedbackGenerator.shared.generate(for: .dismissSheet)
                #endif
                
                dismiss()
            }
        }
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Inteface

    @inlinable
    public func toolbarWithCloseButton(
        isTrailing: Bool = true,
        using dismiss: DismissAction
    ) -> some View {
        toolbar {
            ToolbarItem.closeButton(using: dismiss)
        }
    }
}

#if DEBUG

// MARK: - Previews

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    CloseButton {}
}

#endif

#endif
