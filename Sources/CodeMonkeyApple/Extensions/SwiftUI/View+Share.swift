//
//  View+Share.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/3/22.
//

#if canImport(UIKit)

import Foundation
import SwiftUI

public typealias ActivityItemFactory<ActivityItem> = (ActivityItem) -> Any where ActivityItem: Equatable

extension View {
    // MARK: Public Instance Interface
    
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
        viewControllerSpringboard(with: activityItem) { viewController, _, item in
            activityItem.wrappedValue = nil
            
            let platformActivityItem = factory(item)
            let activityViewController = UIActivityViewController(activityItem: platformActivityItem)
            
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
}

#endif
