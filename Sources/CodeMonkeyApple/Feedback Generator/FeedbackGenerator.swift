//
//  FeedbackGenerator.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/30/21.
//

#if canImport(UIKit)

import Foundation
import UIKit

public final class FeedbackGenerator {
    public typealias IsDisabledProvider = () -> Bool
    public typealias IsEnabledProvider = () -> Bool
    
    public static let shared = FeedbackGenerator()
    
    private var isEnabledProvider: IsEnabledProvider?
    
    // MARK: Public Initialization
    
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
    
    public convenience init(isEnabledKey: String, userDefaults: UserDefaults = .standard) {
        self.init(
            isEnabledProvider: {
                userDefaults.bool(forKey: isEnabledKey)
            }
        )
    }
    
    public init(isEnabledProvider: @escaping IsEnabledProvider) {
        self.isEnabledProvider = isEnabledProvider
    }
    
    public init() {
        isEnabledProvider = nil
    }
    
    // MARK: Public Instance Interface
    
    @discardableResult
    public func generate(using receipt: Receipt) -> Receipt {
        generate(receipt.feedbackAndPlatformGenerator).asReceipt
    }
    
    @discardableResult
    public func generate(_ feedback: Feedback?) -> Receipt? {
        guard let feedback = feedback else {
            return nil
        }

        return generate(feedback)
    }
    
    @discardableResult
    public func generate(_ feedback: Feedback) -> Receipt {
        generate(.from(feedback)).asReceipt
    }
    
    @discardableResult
    public func generate(for semanticFeedback: SemanticFeedback?) -> Receipt? {
        guard let semanticFeedback = semanticFeedback else {
            return nil
        }

        return generate(semanticFeedback.base) as Receipt
    }
    
    @discardableResult
    public func generate(for semanticFeedback: SemanticFeedback) -> Receipt {
        generate(semanticFeedback.base)
    }

    public func prepare(_ feedback: Feedback) -> Receipt {
        let feedbackAndPlatformGenerator = FeedbackAndPlatformGenerator.from(feedback)
        feedbackAndPlatformGenerator.platformGenerator.prepare()
        
        return Receipt(feedbackAndPlatformGenerator)
    }

    public func prepare(for semanticFeedback: SemanticFeedback) -> Receipt {
        prepare(semanticFeedback.base)
    }
    
    public func prepareAgain(_ receipt: Receipt) -> Receipt {
        receipt.feedbackAndPlatformGenerator.platformGenerator.prepare()
        
        return receipt
    }
    
    public func setIsDisabled(basedOn isDisabledKey: String, in userDefaults: UserDefaults = .standard) {
        setIsDisabled {
            userDefaults.bool(forKey: isDisabledKey)
        }
    }
    
    public func setIsDisabled(basedOn isDisabledProvider: @escaping IsDisabledProvider) {
        isEnabledProvider = {
            not(isDisabledProvider())
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

    // MARK: Private Instance Interface
    
    private var isEnabled: Bool {
        isEnabledProvider?() ?? true
    }

    private func generate(_ feedback: Feedback.Impact, using platformGenerator: UIImpactFeedbackGenerator) {
        if let intensity = feedback.intensity {
            platformGenerator.impactOccurred(intensity: intensity)
        } else {
            platformGenerator.impactOccurred()
        }
    }
    
    private func generate(_ feedback: Feedback.Notification, using platformGenerator: UINotificationFeedbackGenerator) {
        platformGenerator.notificationOccurred(feedback.platformType)
    }
    
    private func generate(_ feedback: Feedback.Selection, using platformGenerator: UISelectionFeedbackGenerator) {
        switch feedback {
        case .selectionChanged:
            platformGenerator.selectionChanged()
        }
    }
    
    private func generate(
        _ feedbackAndPlatformGenerator: FeedbackAndPlatformGenerator
    ) -> FeedbackAndPlatformGenerator {
        guard isEnabled else {
            return feedbackAndPlatformGenerator
        }
        
        switch feedbackAndPlatformGenerator {
        case let .impact(impact, platformGenerator):
            generate(impact, using: platformGenerator)
        case let .notification(notification, platformGenerator):
            generate(notification, using: platformGenerator)
        case let .selection(selection, platformGenerator):
            generate(selection, using: platformGenerator)
        }
        
        return feedbackAndPlatformGenerator
    }
}

// MARK: - FeedbackGenerator.Feedback Definition

extension FeedbackGenerator {
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

// MARK: - FeedbackGenerator.Feedback.Impact Definition

extension FeedbackGenerator.Feedback {
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

// MARK: - FeedbackGenerator.Feedback.Notification Definition

extension FeedbackGenerator.Feedback {
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

// MARK: - FeedbackGenerator.Feedback.Selection Definition

extension FeedbackGenerator.Feedback {
    public enum Selection: SynthesizedIdentifiable {
        case selectionChanged
    }
}

// MARK: - FeedbackGenerator.FeedbackAndPlatformGenerator Definition

extension FeedbackGenerator {
    internal enum FeedbackAndPlatformGenerator {
        case impact(Feedback.Impact, UIImpactFeedbackGenerator)
        case notification(Feedback.Notification, UINotificationFeedbackGenerator)
        case selection(Feedback.Selection, UISelectionFeedbackGenerator)
        
        // MARK: Internal Static Interface
        
        internal static func from(_ feedback: Feedback) -> FeedbackAndPlatformGenerator {
            switch feedback {
            case let .impact(feedback):
                return .impact(feedback)
            case let .notification(feedback):
                return .notification(feedback)
            case let .selection(feedback):
                return .selection(feedback)
            }
        }
        
        internal static func impact(_ feedback: Feedback.Impact) -> FeedbackAndPlatformGenerator {
            .impact(feedback, UIImpactFeedbackGenerator(style: feedback.platformType))
        }
        
        internal static func notification(_ feedback: Feedback.Notification) -> FeedbackAndPlatformGenerator {
            .notification(feedback, UINotificationFeedbackGenerator())
        }
        
        internal static func selection(_ feedback: Feedback.Selection) -> FeedbackAndPlatformGenerator {
            .selection(feedback, UISelectionFeedbackGenerator())
        }
        
        // MARK: Internal Instance Interface
        
        internal var asReceipt: Receipt {
            Receipt(self)
        }
        
        internal var platformGenerator: UIFeedbackGenerator {
            switch self {
            case let .impact(_, platformGenerator):
                return platformGenerator
            case let .notification(_, platformGenerator):
                return platformGenerator
            case let .selection(_, platformGenerator):
                return platformGenerator
            }
        }
    }
}

// MARK: - FeedbackGenerator.Receipt Definition

extension FeedbackGenerator {
    public struct Receipt {
        internal let feedbackAndPlatformGenerator: FeedbackAndPlatformGenerator
        
        // MARK: Internal Initialization
        
        internal init(_ feedbackAndPlatformGenerator: FeedbackAndPlatformGenerator) {
            self.feedbackAndPlatformGenerator = feedbackAndPlatformGenerator
        }
    }
}


// MARK: - FeedbackGenerator.SemanticFeedback Definition

extension FeedbackGenerator {
    public struct SemanticFeedback {
        public let base: Feedback
        
        // MARK: Public Initialization
        
        public init(_ base: Feedback) {
            self.base = base
        }
    }
}

#endif
