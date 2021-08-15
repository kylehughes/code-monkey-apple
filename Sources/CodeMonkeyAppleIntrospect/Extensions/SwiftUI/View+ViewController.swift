//
//  View+ViewController.swift
//  CodeMonkeyAppleIntrospect
//
//  Created by Kyle Hughes on 6/1/21.
//

#if canImport(UIKit)

import CodeMonkeyApple
import Introspect
import SwiftUI
import UIKit

public typealias ActivityItemFactory<ActivityItem> = (ActivityItem) -> Any where ActivityItem: Equatable

extension View {
    // MARK: Present View Controllers
    
    public func viewController(_ viewController: UIViewController, when shouldPresent: Binding<Bool>) -> some View {
        onChange(of: shouldPresent.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { presenter in
            guard shouldPresent.wrappedValue else {
                return
            }
            
            presenter.present(viewController, animated: true) {
                shouldPresent.wrappedValue = false
            }
        }
    }
    
    public func viewController(
        when shouldPresent: Binding<Bool>,
        viewController: @escaping () -> UIViewController
    ) -> some View {
        onChange(of: shouldPresent.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { presenter in
            guard shouldPresent.wrappedValue else {
                return
            }
            
            presenter.present(viewController(), animated: true) {
                shouldPresent.wrappedValue = false
            }
        }
    }
    
    public func viewController<Value>(
        with value: Binding<Value?>,
        viewController: @escaping (Value) -> UIViewController
    ) -> some View where Value: Equatable {
        onChange(of: value.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { presenter in
            guard let unwrappedValue = value.wrappedValue else {
                return
            }
            
            presenter.present(viewController(unwrappedValue), animated: true) {
                value.wrappedValue = nil
            }
        }
    }
    
    // MARK: Share Activity Items
    
    public func share<ActivityItem>(
        activityItem: Binding<ActivityItem?>
    ) -> some View where ActivityItem: CodeMonkeyApple.ActivityItem {
        share(activityItem: activityItem) {
            $0.platformActivityItem
        }
    }
    
    public func share<ActivityItem>(
        activityItem: Binding<ActivityItem?>,
        factory: @escaping ActivityItemFactory<ActivityItem>
    ) -> some View where ActivityItem: Equatable {
        onChange(of: activityItem.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { viewController in
            guard let activityItemValue = activityItem.wrappedValue else {
                return
            }
            
            activityItem.wrappedValue = nil
            
            let platformActivityItem = factory(activityItemValue)
            let activityViewController = UIActivityViewController(activityItem: platformActivityItem)
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    public func share<ActivityItem>(
        activityItems: Binding<[ActivityItem]?>,
        factory: @escaping ActivityItemFactory<ActivityItem>
    ) -> some View where ActivityItem: Equatable {
        onChange(of: activityItems.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { viewController in
            guard let activityItemsValue = activityItems.wrappedValue else {
                return
            }
            
            activityItems.wrappedValue = nil
            
            let platformActivityItems = activityItemsValue.map(factory)
            let activityViewController = UIActivityViewController(activityItems: platformActivityItems)
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    public func share(activityItem: @autoclosure @escaping () -> Any, when shouldPresent: Binding<Bool>) -> some View {
        share(activityItems: [activityItem], when: shouldPresent)
    }
    
    public func share(
        activityItems: @autoclosure @escaping () -> [Any],
        when shouldPresent: Binding<Bool>
    ) -> some View {
        onChange(of: shouldPresent.wrappedValue) { _ in
            // Only exists to cause the introspection code to be re-run.
        }
        .introspectViewController { viewController in
            guard shouldPresent.wrappedValue else {
                return
            }
            
            let activityViewController = UIActivityViewController(activityItems: activityItems())
            
            viewController.present(activityViewController, animated: true) {
                shouldPresent.wrappedValue = false
            }
        }
    }
}

#endif
