//
//  DeviceDidShakeViewModifier.swift
//  SuperHeadache
//
//  Created by Kyle Hughes on 8/21/21.
//

import SwiftUI
import UIKit

public struct DeviceShakeViewModifier: ViewModifier {
    internal let action: () async -> Void
    
    // MARK: Public Instance Interface

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                Task {
                    await action()
                }
            }
    }
}

// MARK: - Extension for View

extension View {
    // MARK: Public Instance Interface
    
    public func onShake(perform action: @escaping () async -> Void) -> some View {
        modifier(DeviceShakeViewModifier(action: action))
    }
}

// MARK: - Extension for UIDevice

extension UIDevice {
    public static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

// MARK: - Extension for UIWindow

extension UIWindow {
    // MARK: Internal Instance Interface
    
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }
        
        NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
    }
}

