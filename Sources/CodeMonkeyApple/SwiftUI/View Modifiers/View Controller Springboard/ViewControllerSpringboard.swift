//
//  ViewControllerSpringboard.swift
//  Music Triage
//
//  Created by Kyle Hughes on 10/2/22.
//

#if canImport(UIKit) && !os(watchOS)

import StoreKit
import SwiftUI

/// A `UIViewControllerRepresentable` implementation that provides access to a blank view controller to present on top
/// of within a SwiftUI context, as well as coordinator access to implement any delegates.
///
/// This was originally made for the sake of `SKStoreProductViewController` and its need to be presented modally. It
/// does not work as a representable implementer.
public struct ViewControllerSpringboard<Coordinator, Item> {
    public typealias Action = (UIViewController, Coordinator, Item) -> Void
    public typealias CoordinatorFactory = () -> Coordinator
    
    private let _makeCoordinator: CoordinatorFactory
    private let action: Action
    
    @Binding private var item: Item?
    
    // MARK: Public Initialization

    public init(item: Binding<Item?>, makeCoordinator: @escaping CoordinatorFactory, action: @escaping Action) {
        self.action = action
        
        _item = item
        _makeCoordinator = makeCoordinator
    }
}

// MARK: - UIViewControllerRepresentable Extension

extension ViewControllerSpringboard: UIViewControllerRepresentable {
    // MARK: Creating and Updating the View Controller
    
    public func makeCoordinator() -> Coordinator {
        _makeCoordinator()
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let item else {
            return
        }
        
        action(uiViewController, context.coordinator, item)
    }
}

// MARK: - ViewControllerSpringboard.ViewModifier Definition

extension ViewControllerSpringboard {
    public struct ViewModifier {
        private let _makeCoordinator: CoordinatorFactory
        private let action: Action
        
        @Binding private var item: Item?
        
        // MARK: Public Initialization
        
        public init(isPresented: Binding<Bool>, action: @escaping Action) where Coordinator == Void, Item == Void {
            self.init(isPresented: isPresented) {
                // NO-OP
            } action: {
                action($0, $1, $2)
            }
        }
        
        public init(
            isPresented: Binding<Bool>,
            makeCoordinator: @escaping CoordinatorFactory,
            action: @escaping Action
        ) where Item == Void {
            self.init(
                item: Binding {
                    isPresented.wrappedValue ? () : nil
                } set: {
                    isPresented.wrappedValue = $0 != nil
                }
            ) {
                makeCoordinator()
            } action: {
                action($0, $1, $2)
            }
        }
        
        public init(item: Binding<Item?>, action: @escaping Action) where Coordinator == Void {
            self.init(item: item) {
                // NO-OP
            } action: {
                action($0, $1, $2)
            }
        }
        
        public init(
            item: Binding<Item?>,
            makeCoordinator: @escaping CoordinatorFactory,
            action: @escaping Action
        ) {
            self.action = action
            
            _item = item
            _makeCoordinator = makeCoordinator
        }
    }
}

// MARK: - ViewModifier Extension

extension ViewControllerSpringboard.ViewModifier: ViewModifier {
    // MARK: Modifier Body
    
    public func body(content: Content) -> some View {
        content
            .background(ViewControllerSpringboard(item: $item, makeCoordinator: _makeCoordinator, action: action))
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func viewControllerSpringboard(
        isPresented: Binding<Bool>,
        action: @escaping ViewControllerSpringboard<Void, Void>.Action
    ) -> some View {
        modifier(ViewControllerSpringboard.ViewModifier(isPresented: isPresented, action: action))
    }
    
    public func viewControllerSpringboard<Coordinator>(
        isPresented: Binding<Bool>,
        makeCoordinator: @escaping ViewControllerSpringboard<Coordinator, Void>.CoordinatorFactory,
        action: @escaping ViewControllerSpringboard<Coordinator, Void>.Action
    ) -> some View {
        modifier(
            ViewControllerSpringboard.ViewModifier(
                isPresented: isPresented,
                makeCoordinator: makeCoordinator,
                action: action
            )
        )
    }
    
    public func viewControllerSpringboard<Item>(
        with item: Binding<Item?>,
        action: @escaping ViewControllerSpringboard<Void, Item>.Action
    ) -> some View {
        modifier(ViewControllerSpringboard.ViewModifier(item: item, action: action))
    }
    
    public func viewControllerSpringboard<Coordinator, Item>(
        with item: Binding<Item?>,
        makeCoordinator: @escaping ViewControllerSpringboard<Coordinator, Item>.CoordinatorFactory,
        action: @escaping ViewControllerSpringboard<Coordinator, Item>.Action
    ) -> some View {
        modifier(ViewControllerSpringboard.ViewModifier(item: item, makeCoordinator: makeCoordinator, action: action))
    }
}

#endif
