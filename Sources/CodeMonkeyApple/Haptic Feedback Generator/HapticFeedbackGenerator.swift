//
//  HapticFeedbackGenerator.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/30/21.
//

#if canImport(UIKit)

import Foundation
import UIKit

// MARK: - HapticFeedback Definition

/// A convenience wrapper for `HapticFeedbackGenerator.shared`.
public enum HapticFeedback {
    // MARK: Public Static Interface
    
    @inlinable
    public static func generate(using preparedFeedback: HapticFeedbackGenerator.PreparedFeedback) {
        HapticFeedbackGenerator.shared.generate(using: preparedFeedback)
    }
    
    @inlinable
    public static func generate(_ feedback: HapticFeedbackGenerator.Feedback?) {
        HapticFeedbackGenerator.shared.generate(feedback)
    }
    
    @inlinable
    public static func generate(_ feedback: HapticFeedbackGenerator.Feedback) {
        HapticFeedbackGenerator.shared.generate(feedback)
    }
    
    @inlinable
    public static func generate(for semanticFeedback: HapticFeedbackGenerator.SemanticFeedback?) {
        HapticFeedbackGenerator.shared.generate(for: semanticFeedback)
    }
    
    @inlinable
    public static func generate(for semanticFeedback: HapticFeedbackGenerator.SemanticFeedback) {
        HapticFeedbackGenerator.shared.generate(for: semanticFeedback)
    }

    @inlinable
    public static func prepare(
        _ feedback: HapticFeedbackGenerator.Feedback
    ) -> HapticFeedbackGenerator.PreparedFeedback {
        HapticFeedbackGenerator.shared.prepare(feedback)
    }

    @inlinable
    public static func prepare(
        for semanticFeedback: HapticFeedbackGenerator.SemanticFeedback
    ) -> HapticFeedbackGenerator.PreparedFeedback {
        HapticFeedbackGenerator.shared.prepare(for: semanticFeedback)
    }
    
    @inlinable
    public static func prepareAgain(_ preparedFeedback: HapticFeedbackGenerator.PreparedFeedback) {
        HapticFeedbackGenerator.shared.prepareAgain(preparedFeedback)
    }
    
    @inlinable
    public static func setIsDisabled(_ isDisabled: Bool) {
        HapticFeedbackGenerator.shared.setIsDisabled(isDisabled)
    }
    
    @inlinable
    public static func setIsDisabled(basedOn isDisabledKey: String, in userDefaults: UserDefaults = .standard) {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isDisabledKey, in: userDefaults)
    }
    
    @inlinable
    public static func setIsDisabled(basedOn isDisabledProvider: @escaping HapticFeedbackGenerator.IsDisabledProvider) {
        HapticFeedbackGenerator.shared.setIsDisabled(basedOn: isDisabledProvider)
    }
    
    @inlinable
    public static func setIsEnabled(_ isEnabled: Bool) {
        HapticFeedbackGenerator.shared.setIsEnabled(isEnabled)
    }
    
    @inlinable
    public static func setIsEnabled(basedOn isEnabledKey: String, in userDefaults: UserDefaults = .standard) {
        HapticFeedbackGenerator.shared.setIsEnabled(basedOn: isEnabledKey, in: userDefaults)
    }
    
    @inlinable
    public static func setIsEnabled(basedOn isEnabledProvider: @escaping HapticFeedbackGenerator.IsEnabledProvider) {
        HapticFeedbackGenerator.shared.setIsEnabled(basedOn: isEnabledProvider)
    }
}

// MARK: - HapticFeedbackGenerator Definition

public final class HapticFeedbackGenerator {
    public typealias IsDisabledProvider = () -> Bool
    public typealias IsEnabledProvider = () -> Bool
    
    public static let shared = HapticFeedbackGenerator()
    
    private var isEnabledProvider: IsEnabledProvider
    
    // MARK: Public Initialization
    
    public convenience init(isDisabled: Bool) {
        self.init(
            isDisabledProvider: {
                isDisabled
            }
        )
    }
    
    public convenience init(isDisabledKey: String, userDefaults: UserDefaults = .standard) {
        self.init(
            isDisabledProvider: {
                userDefaults.bool(forKey: isDisabledKey)
            }
        )
    }
    
    public convenience init(isDisabledProvider: @escaping IsDisabledProvider) {
        self.init(
            isEnabledProvider: {
                not(isDisabledProvider())
            }
        )
    }
    
    public convenience init(isEnabled: Bool) {
        self.init(
            isEnabledProvider: {
                isEnabled
            }
        )
    }
    
    public convenience init(isEnabledKey: String, userDefaults: UserDefaults = .standard) {
        self.init(
            isEnabledProvider: {
                userDefaults.bool(forKey: isEnabledKey)
            }
        )
    }
    
    public convenience init() {
        self.init(isEnabled: true)
    }
    
    public init(isEnabledProvider: @escaping IsEnabledProvider) {
        self.isEnabledProvider = isEnabledProvider
    }
    
    // MARK: Public Instance Interface
    
    public func generate(using preparedFeedback: PreparedFeedback) {
        preparedFeedback()
    }
    
    public func generate(_ feedback: Feedback?) {
        guard let feedback = feedback else {
            return
        }

        generate(feedback)
    }
    
    public func generate(_ feedback: Feedback) {
        FeedbackAndGenerator.from(feedback, isEnabledProvider)()
    }
    
    public func generate(for semanticFeedback: SemanticFeedback?) {
        guard let semanticFeedback = semanticFeedback else {
            return
        }

        generate(semanticFeedback.base)
    }
    
    public func generate(for semanticFeedback: SemanticFeedback) {
        generate(semanticFeedback.base)
    }

    public func prepare(_ feedback: Feedback) -> PreparedFeedback {
        PreparedFeedback(using: .from(feedback, isEnabledProvider))
    }

    public func prepare(for semanticFeedback: SemanticFeedback) -> PreparedFeedback {
        prepare(semanticFeedback.base)
    }
    
    public func prepareAgain(_ preparedFeedback: PreparedFeedback) {
        preparedFeedback.prepareAgain()
    }
    
    public func setIsDisabled(_ isDisabled: Bool) {
        setIsDisabled {
            isDisabled
        }
    }
    
    public func setIsDisabled(basedOn isDisabledKey: String, in userDefaults: UserDefaults = .standard) {
        setIsDisabled {
            userDefaults.bool(forKey: isDisabledKey)
        }
    }
    
    public func setIsDisabled(basedOn isDisabledProvider: @escaping IsDisabledProvider) {
        setIsEnabled {
            not(isDisabledProvider())
        }
    }
    
    public func setIsEnabled(_ isEnabled: Bool) {
        setIsEnabled {
            isEnabled
        }
    }
    
    public func setIsEnabled(basedOn isEnabledKey: String, in userDefaults: UserDefaults = .standard) {
        setIsEnabled {
            userDefaults.bool(forKey: isEnabledKey)
        }
    }
    
    public func setIsEnabled(basedOn isEnabledProvider: @escaping IsEnabledProvider) {
        self.isEnabledProvider = isEnabledProvider
    }
}

// MARK: - HapticFeedbackGenerator.Feedback Definition

extension HapticFeedbackGenerator {
    public enum Feedback: SynthesizedIdentifiable {
        case impact(Impact)
        case notification(Notification)
        case selection(Selection)
        
        // MARK: Public Static Interface
        
        public static var selection: Feedback {
            .selection(.selectionChanged)
        }
    }
}

// MARK: - HapticFeedbackGenerator.Feedback.Impact Definition

extension HapticFeedbackGenerator.Feedback {
    public enum Impact: SynthesizedIdentifiable {
        case heavy(CGFloat? = nil)
        case light(CGFloat? = nil)
        case medium(CGFloat? = nil)
        case rigid(CGFloat? = nil)
        case soft(CGFloat? = nil)
        
        // MARK: Public Static Interface
        
        public static var heavy: Impact {
            .heavy()
        }
        
        public static var light: Impact {
            .light()
        }
        
        public static var medium: Impact {
            .medium()
        }
        
        public static var rigid: Impact {
            .rigid()
        }
        
        public static var soft: Impact {
            .soft()
        }
        
        // MARK: Public Instance Interface
        
        public var intensity: CGFloat? {
            switch self {
            case
                let .heavy(intensity),
                let .light(intensity),
                let .medium(intensity),
                let .rigid(intensity),
                let .soft(intensity)
            :
                return intensity
            }
        }
        
        public var platformType: UIImpactFeedbackGenerator.FeedbackStyle {
            switch self {
            case .heavy:
                return .heavy
            case .light:
                return .light
            case .medium:
                return .medium
            case .rigid:
                return .rigid
            case .soft:
                return .soft
            }
        }
    }
}

// MARK: - HapticFeedbackGenerator.Feedback.Notification Definition

extension HapticFeedbackGenerator.Feedback {
    public enum Notification: SynthesizedIdentifiable {
        case error
        case success
        case warning
        
        // MARK: Public Instance Interface
        
        public var platformType: UINotificationFeedbackGenerator.FeedbackType {
            switch self {
            case .error:
                return .error
            case .success:
                return .success
            case .warning:
                return .warning
            }
        }
    }
}

// MARK: - HapticFeedbackGenerator.Feedback.Selection Definition

extension HapticFeedbackGenerator.Feedback {
    public enum Selection: SynthesizedIdentifiable {
        case selectionChanged
    }
}

// MARK: - HapticFeedbackGenerator.FeedbackAndGenerator Definition

extension HapticFeedbackGenerator {
    fileprivate enum FeedbackAndGenerator {
        case impact(Feedback.Impact, UIImpactFeedbackGenerator, IsEnabledProvider)
        case notification(Feedback.Notification, UINotificationFeedbackGenerator, IsEnabledProvider)
        case selection(Feedback.Selection, UISelectionFeedbackGenerator, IsEnabledProvider)
        
        // MARK: Fileprivate Static Interface
        
        fileprivate static func from(
            _ feedback: Feedback,
            _ isEnabledProvider: @escaping IsEnabledProvider
        ) -> FeedbackAndGenerator {
            switch feedback {
            case let .impact(feedback):
                return .impact(feedback, isEnabledProvider)
            case let .notification(feedback):
                return .notification(feedback, isEnabledProvider)
            case let .selection(feedback):
                return .selection(feedback, isEnabledProvider)
            }
        }
        
        fileprivate static func impact(
            _ feedback: Feedback.Impact,
            _ isEnabledProvider: @escaping IsEnabledProvider
        ) -> FeedbackAndGenerator {
            .impact(feedback, UIImpactFeedbackGenerator(style: feedback.platformType), isEnabledProvider)
        }
        
        fileprivate static func notification(
            _ feedback: Feedback.Notification,
            _ isEnabledProvider: @escaping IsEnabledProvider
        ) -> FeedbackAndGenerator {
            .notification(feedback, UINotificationFeedbackGenerator(), isEnabledProvider)
        }
        
        fileprivate static func selection(
            _ feedback: Feedback.Selection,
            _ isEnabledProvider: @escaping IsEnabledProvider
        ) -> FeedbackAndGenerator {
            .selection(feedback, UISelectionFeedbackGenerator(), isEnabledProvider)
        }
        
        // MARK: Fileprivate Instance Interface

        fileprivate func callAsFunction() {
            switch self {
            case let .impact(impact, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                if let intensity = impact.intensity {
                    generator.impactOccurred(intensity: intensity)
                } else {
                    generator.impactOccurred()
                }
            case let .notification(notification, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                generator.notificationOccurred(notification.platformType)
            case let .selection(selection, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                switch selection {
                case .selectionChanged:
                    generator.selectionChanged()
                }
            }
        }
        
        fileprivate func prepare() {
            switch self {
            case let .impact(_, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                generator.prepare()
            case let .notification(_, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                generator.prepare()
            case let .selection(_, generator, isEnabledProvider):
                guard isEnabledProvider() else {
                    return
                }
                
                generator.prepare()
            }
        }
    }
}

// MARK: - HapticFeedbackGenerator.PreparedFeedback Definition

extension HapticFeedbackGenerator {
    public struct PreparedFeedback {
        fileprivate let feedbackAndGenerator: FeedbackAndGenerator
        
        // MARK: Fileprivate Initialization
        
        fileprivate init(using feedbackAndGenerator: FeedbackAndGenerator) {
            self.feedbackAndGenerator = feedbackAndGenerator

            feedbackAndGenerator.prepare()
        }
        
        // MARK: Public Instance Interface
        
        public func callAsFunction() {
            feedbackAndGenerator()
        }
        
        public func prepareAgain() {
            feedbackAndGenerator.prepare()
        }
    }
}

// MARK: - HapticFeedbackGenerator.SemanticFeedback Definition

extension HapticFeedbackGenerator {
    public struct SemanticFeedback {
        fileprivate let base: Feedback
        
        // MARK: Public Initialization
        
        public init(_ base: Feedback) {
            self.base = base
        }
    }
}

#endif
