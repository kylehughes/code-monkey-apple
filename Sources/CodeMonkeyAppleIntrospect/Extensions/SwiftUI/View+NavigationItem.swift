//
//  View+NavigationItem.swift
//  CodeMonkeyAppleIntrospect
//
//  Created by Kyle Hughes on 8/15/21.
//

#if canImport(Introspect)
import CodeMonkeyApple
import Introspect
import SwiftUI

@available(iOS 15.0, *)
extension View {
    // MARK: Public Instance Interface
    
    public func navigationBarItemToClose(_ dismiss: DismissAction) -> some View {
        introspectViewController { viewController in
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
                systemItem: .close,
                primaryAction: UIAction(
                    handler: { _ in
                        HapticFeedback.generate(for: .dismissSheet)
                        dismiss()
                    }
                )
            )
        }
    }
}

#endif
