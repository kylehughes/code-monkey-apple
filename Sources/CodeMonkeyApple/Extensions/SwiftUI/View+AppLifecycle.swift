//
//  View+AppLifecycle.swift
//  SuperHeadaache
//
//  Created by Kyle Hughes on 8/22/21.
//

#if canImport(UIKit) && !os(watchOS)

import SwiftUI
import UIKit

extension View {
    // MARK: Public Instance Interface
    
    public func onAppEnterForeground(perform: @escaping () -> Void) -> some View {
        onReceive(
            NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
        ) { _ in
            perform()
        }
    }
    
    public func onSignificantTimeChange(perform: @escaping () -> Void) -> some View {
        onReceive(
            NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)
        ) { _ in
            perform()
        }
    }
}

#endif
