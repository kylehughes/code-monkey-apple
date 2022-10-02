//
//  CloseButton.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/29/22.
//

#if !os(macOS)

import Foundation
import SwiftUI

#if canImport(UIKit) && !os(watchOS)
import UIKit
#endif

public struct CloseButton {
    private let action: () -> Void
    
    // MARK: Public Initalization
    
    public init(dismiss: DismissAction) {
        self.init(action: dismiss.callAsFunction)
    }
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
}

// MARK: - View Extension

extension CloseButton: View {
    // MARK: View Body
    
    public var body: some View {
        Button {
            #if canImport(UIKit) && !os(watchOS)
            HapticFeedbackGenerator.shared.generate(for: .dismissSheet)
            #endif
            
            action()
        } label: {
            Image(systemName: "xmark")
                .resizable()
        }
        .buttonStyle(Style())
        .tint(.primary)
    }
}

#if DEBUG

// MARK: - Previews

struct CloseButton_Previews: PreviewProvider {
    // MARK: Preview Body
    
    static var previews: some View {
        NavigationView {
            Color.white
                .ignoresSafeArea()
                .navigationTitle("Preview")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CloseButton {
                            
                        }
                    }
                }
        }
    }
}

#endif

// MARK: - CloseButton.Style Definition

extension CloseButton {
    struct Style {
        @Environment(\.colorScheme) private var colorScheme
    }
}

// MARK: - ButtonStyle Extension

extension CloseButton.Style: ButtonStyle {
    // MARK: Internal Instance Interface
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .symbolRenderingMode(.hierarchical)
            .font(.body.weight(.heavy))
            .foregroundStyle(.secondary)
            .opacity(configuration.isPressed ? 0.2 : 1.0)
            .animation(
                .linear(duration: configuration.isPressed ? 0.00 : 0.3),
                value: configuration.isPressed
            )
            .padding(1.4)
            .frame(width: 15.333, height: 15.333)
            .padding(7.6)
            .aspectRatio(contentMode: .fit)
            .background(backgroundColor.opacity(0.0575), in: controlShape)
            .contentShape(controlShape)
    }
    
    // MARK: Subviews
    
    private var controlShape: some Shape {
        Circle()
    }
    
    private var backgroundColor: Color {
        switch colorScheme {
        case .dark:
            return .white
        case .light:
            return .black
        @unknown default:
            return .black
        }
    }
}

// MARK: - Extension for ToolbarItem

extension ToolbarItem<(), CloseButton> {
    // MARK: Public Static Interface
    
    public static func closeButton(
        isTrailing: Bool = true,
        using dismiss: DismissAction
    ) -> Self {
        ToolbarItem(placement: isTrailing ? .navigationBarTrailing : .navigationBarLeading) {
            CloseButton(dismiss: dismiss)
        }
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Inteface
    
    public func toolbarWithCloseButton(
        isTrailing: Bool = true,
        using dismiss: DismissAction
    ) -> some View {
        toolbar {
            ToolbarItem.closeButton(using: dismiss)
        }
    }
}

#endif
