//
//  View+Share.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/3/22.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation
import SwiftUI

public typealias ActivityItemFactory<ActivityItem> = (ActivityItem) -> Any where ActivityItem: Equatable

extension View {
    // MARK: Public Instance Interface
    
    @available(*, deprecated, message: "Presentation gets stuck in infinite loop.")
    public func share<ActivityItem>(
        activityItem: Binding<ActivityItem?>
    ) -> some View where ActivityItem: CodeMonkeyApple.ActivityItem {
        share(activityItem: activityItem) {
            $0.platformActivityItem
        }
    }
    
    @available(*, deprecated, message: "Presentation gets stuck in infinite loop.")
    public func share<ActivityItem>(
        activityItem: Binding<ActivityItem?>,
        factory: @escaping ActivityItemFactory<ActivityItem>
    ) -> some View where ActivityItem: Equatable {
        viewControllerSpringboard(with: activityItem) { viewController, _, item in
            let platformActivityItem = factory(item)
            let activityViewController = UIActivityViewController(activityItem: platformActivityItem)
            
            activityViewController.allowsProminentActivity = true
            
            activityViewController.completionWithItemsHandler = { _, _, _, _ in
                activityItem.wrappedValue = nil
            }
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}

#endif
