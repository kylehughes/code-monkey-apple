//
//  HapticFeedbackGenerator+Constants.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/14/21.
//

#if canImport(UIKit)

extension HapticFeedbackGenerator.SemanticFeedback {
    public static let dismissSheet = Self(.impact(.light))
    public static let presentSheet = Self(.impact(.medium))
}

#endif
