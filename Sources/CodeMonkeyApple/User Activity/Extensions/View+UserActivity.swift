//
//  View+UserActivity.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/22/21.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    public func userActivity(
        _ userActivity: EmptyUserActivity,
        isActive: Bool = true
    ) -> some View {
        self.userActivity(userActivity.id.rawValue, isActive: false, userActivity.update)
    }
    
    public func userActivity<UserActivity>(
        _ userActivity: UserActivity,
        isActive: Bool = true
    ) -> some View where UserActivity: CodeMonkeyApple.UserActivity {
        self.userActivity(userActivity.id.rawValue, isActive: isActive, userActivity.update)
    }
}
