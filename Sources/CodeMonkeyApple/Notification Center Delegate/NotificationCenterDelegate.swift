//
//  NotificationCenterDelegate.swift
//  Common
//
//  Created by Kyle Hughes on 4/19/22.
//

import Combine
import UserNotifications

public final class NotificationCenterDelegate: NSObject {
    private let goToNotificationSettingsSubject: CurrentValueSubject<Bool, Never>
    
    // MARK: Public Initialization
    
    public init(userNotificationCenter: UNUserNotificationCenter = .current()) {
        goToNotificationSettingsSubject = CurrentValueSubject(false)
        
        super.init()
        
        userNotificationCenter.delegate = self
    }
    
    // MARK: Public Instance Interface
    
    public func didGoToNotificationSettings() {
        goToNotificationSettingsSubject.value = false
    }

    public var goToNotificationSettings: AnyPublisher<Bool, Never> {
        goToNotificationSettingsSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

// MARK: - UNUserNotificationCenterDelegate Extension

extension NotificationCenterDelegate: UNUserNotificationCenterDelegate {
    #if !os(watchOS)
    
    // MARK: Displaying Notification Settings
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        openSettingsFor notification: UNNotification?
    ) {
        goToNotificationSettingsSubject.value = true
    }
    
    #endif
}
