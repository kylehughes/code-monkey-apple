//
//  Color+Constants.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/11/21.
//

import SwiftUI

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension Color {
    // MARK: Grays
    
    public static let lightGray = Color(.lightGray)
    
    // MARK: System Grouped Backgrounds
    
    public static let secondarySystemGroupedBackground = Color(.secondarySystemGroupedBackground)
    public static let systemGroupedBackground = Color(.systemGroupedBackground)
    public static let tertiarySystemGroupedBackground = Color(.tertiarySystemGroupedBackground)
}

#endif
