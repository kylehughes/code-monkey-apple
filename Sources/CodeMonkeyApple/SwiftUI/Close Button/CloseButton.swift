//
//  CloseButton.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/29/22.
//

#if !os(macOS) && !os(watchOS)

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

private let dimension: CGFloat = 15 + 1/3

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
    fileprivate struct ButtonStyle {
        private let style: Style
        
        @Environment(\.colorScheme) private var colorScheme
        
        // MARK: Fileprivate Initialization
        
        fileprivate init(style: Style) {
            self.style = style
        }
    }
}

// MARK: - ButtonStyle Extension

extension CloseButton.ButtonStyle: ButtonStyle {
    // MARK: Internal Instance Interface
    
    fileprivate func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .symbolRenderingMode(.hierarchical)
            .font(.body.weight(.heavy))
            .foregroundStyle(foregroundStyle)
            .opacity(configuration.isPressed ? 0.2 : 1.0)
            .animation(.linear(duration: configuration.isPressed ? 0.00 : 0.3), value: configuration.isPressed)
            .padding(1.4)
            .frame(width: dimension, height: dimension)
            .padding(7.6)
            .aspectRatio(contentMode: .fit)
            .background(backgroundStyle, in: controlShape)
            .contentShape(controlShape)
    }
    
    // MARK: Subviews
    
    private var controlShape: some Shape {
        Circle()
    }
    
    // MARK: View Properties
    
    private var backgroundStyle: AnyShapeStyle {
        switch style {
        case .hierarchical:
            return AnyShapeStyle(.tertiary)
        case .system:
            return AnyShapeStyle(
                {
                    switch colorScheme {
                    case .dark:
                        return Color.white
                    case .light:
                        return Color.black
                    @unknown default:
                        return Color.black
                    }
                }().opacity(0.0575)
            )
        }
    }
    
    private var foregroundStyle: AnyShapeStyle {
        switch style {
        case .hierarchical:
            return AnyShapeStyle(.primary)
        case .system:
            return AnyShapeStyle(.secondary)
        }
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
