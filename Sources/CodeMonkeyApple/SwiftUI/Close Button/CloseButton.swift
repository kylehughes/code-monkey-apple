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
    private let style: Style
    
    // MARK: Public Initalization
    
    public init(style: Style = .system, dismiss: DismissAction) {
        self.init(style: style, action: dismiss.callAsFunction)
    }
    
    public init(style: Style = .system, action: @escaping () async -> Void) {
        self.init(style: style) {
            Task {
                await action()
            }
        }
    }
    
    public init(style: Style = .system, action: @escaping () -> Void) {
        self.style = style
        self.action = action
    }
}

// MARK: - View Extension

extension CloseButton: View {
    // MARK: View Body
    
    public var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .resizable()
        }
        .buttonStyle(ButtonStyle(style: style))
    }
}

#if DEBUG

// MARK: - Previews

struct CloseButton_Previews: PreviewProvider {
    // MARK: Preview Body
    
    static var previews: some View {
        NavigationView {
            Color.systemGroupedBackground
                .ignoresSafeArea()
                .navigationTitle("Preview")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        CloseButton(style: .system) {
                            
                        }
                        
                        CloseButton(style: .hierarchical) {
                            
                        }
                        .foregroundColor(.red)
                        
                        Image(systemName: "xmark")
                            .symbolRenderingMode(.hierarchical)
                            .symbolVariant(.circle.fill)
                            .font(.body.weight(.medium))
                            .foregroundStyle(.red)
                    }
                }
        }
    }
}

#endif

// MARK: - CloseButton.ButtonStyle Definition

extension CloseButton {
    struct ButtonStyle {
        private let style: Style
        
        @Environment(\.colorScheme) private var colorScheme
        
        // MARK: Internal Initialization
        
        init(style: Style) {
            self.style = style
        }
    }
}

// MARK: - ButtonStyle Extension

extension CloseButton.ButtonStyle: ButtonStyle {
    // MARK: Internal Instance Interface
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .symbolRenderingMode(.hierarchical)
            .font(.body.weight(.heavy))
            .if(style == .hierarchical) {
                $0.foregroundStyle(.primary)
            } else: {
                $0.foregroundStyle(.secondary)
            }
            .foregroundStyle(.primary)
            .opacity(configuration.isPressed ? 0.2 : 1.0)
            .animation(
                .linear(duration: configuration.isPressed ? 0.00 : 0.3),
                value: configuration.isPressed
            )
            .padding(1.4)
            .frame(width: 15.333, height: 15.333)
            .padding(7.6)
            .aspectRatio(contentMode: .fit)
            .if(style == .hierarchical) {
                $0.background(.tertiary, in: controlShape)
            } else: {
                switch colorScheme {
                case .dark:
                    $0.background(.white.opacity(0.0575), in: controlShape)
                case .light:
                    $0.background(.black.opacity(0.0575), in: controlShape)
                @unknown default:
                    $0.background(.black.opacity(0.0575), in: controlShape)
                }
            }
            .contentShape(controlShape)
    }
    
    // MARK: Subviews
    
    private var controlShape: some Shape {
        Circle()
    }
}

// MARK: - CloseButton.Style Definition

extension CloseButton {
    public enum Style {
        case hierarchical
        case system
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
