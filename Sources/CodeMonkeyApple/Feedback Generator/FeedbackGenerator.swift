//
//  FeedbackGenerator.swift
//  Rank Things
//
//  Created by Kyle Hughes on 5/30/21.
//

#if canImport(UIKit)

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
    
    public func generate(_ feedback: Feedback?) {
        guard let feedback = feedback else {
            return
        }

        generate(convertible: feedback)
    }
    
    public func generate(_ feedback: Feedback) {
        generate(convertible: feedback)
    }
    
    public func generate(for semanticFeedback: SemanticFeedback?) {
        guard let semanticFeedback = semanticFeedback else {
            return
        }

        generate(convertible: semanticFeedback)
    }
    
    public func generate(for semanticFeedback: SemanticFeedback) {
        generate(convertible: semanticFeedback)
    }
    
    public func prepare(_ feedback: Feedback?) {
        guard let feedback = feedback else {
            return
        }

        prepare(convertible: feedback)
    }
    
    public func prepare(_ feedback: Feedback) {
        prepare(convertible: feedback)
    }
    
    public func prepare(for semanticFeedback: SemanticFeedback?) {
        guard let semanticFeedback = semanticFeedback else {
            return
        }

        prepare(convertible: semanticFeedback)
    }
    
    public func prepare(for semanticFeedback: SemanticFeedback) {
        prepare(convertible: semanticFeedback)
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
    
    // MARK: Private Lazy Properties
    
    private lazy var heavyImpactNotificationFeedbackGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .heavy)
    }()
    
    private lazy var lightImpactNotificationFeedbackGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .light)
    }()
    
    private lazy var mediumImpactNotificationFeedbackGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .medium)
    }()
    
    private lazy var notificationFeedbackGenerator: UINotificationFeedbackGenerator = {
        UINotificationFeedbackGenerator()
    }()
    
    private lazy var rigidImpactNotificationFeedbackGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .rigid)
    }()
    
    private lazy var selectionFeedbackGenerator: UISelectionFeedbackGenerator = {
        UISelectionFeedbackGenerator()
    }()
    
    private lazy var softImpactNotificationFeedbackGenerator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .soft)
    }()
    
    // MARK: Private Instance Interface
    
    private var isEnabled: Bool {
        isEnabledProvider?() ?? true
    }
    
    private func generate(_ feedback: Feedback.Impact) {
        let feedbackGenerator = getFeedbackGenerator(for: feedback)
        
        if let intensity = feedback.intensity {
            feedbackGenerator.impactOccurred(intensity: intensity)
        } else {
            feedbackGenerator.impactOccurred()
        }
    }
    
    private func generate(_ feedback: Feedback.Notification) {
        notificationFeedbackGenerator.notificationOccurred(feedback.platformType)
    }
    
    private func generate(_ feedback: Feedback.Selection) {
        switch feedback {
        case .selectionChanged:
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    private func generate(convertible: FeedbackGeneratorConvertible) {
        guard isEnabled else {
            return
        }
        
        switch convertible.asFeedback {
        case let .impact(impact):
            generate(impact)
        case let .notification(notification):
            generate(notification)
        case let .selection(selection):
            generate(selection)
        }
    }
    
    private func getFeedbackGenerator(
        for impact: Feedback.Impact
    ) -> UIImpactFeedbackGenerator {
        switch impact {
        case .heavy:
            return heavyImpactNotificationFeedbackGenerator
        case .light:
            return lightImpactNotificationFeedbackGenerator
        case .medium:
            return mediumImpactNotificationFeedbackGenerator
        case .rigid:
            return rigidImpactNotificationFeedbackGenerator
        case .soft:
            return softImpactNotificationFeedbackGenerator
        }
    }
    
    private func prepare(_ feedback: Feedback.Impact) {
        getFeedbackGenerator(for: feedback).prepare()
    }
    
    private func prepare(_ feedback: Feedback.Notification) {
        notificationFeedbackGenerator.prepare()
    }
    
    private func prepare(_ feedback: Feedback.Selection) {
        selectionFeedbackGenerator.prepare()
    }
    
    private func prepare(convertible: FeedbackGeneratorConvertible) {
        guard isEnabled else {
            return
        }
        
        switch convertible.asFeedback {
        case let .impact(impact):
            prepare(impact)
        case let .notification(notification):
            prepare(notification)
        case let .selection(selection):
            prepare(selection)
        }
    }
}

// MARK: - App-Specific Extensions

extension FeedbackGenerator {
    // MARK: Public Initialization
    
    public convenience init(isDisabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isDisabledProvider: {
                userDefaults.getValue(for: isDisabledKey)
            }
        )
    }
    
    public convenience init(isEnabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        self.init(
            isEnabledProvider: {
                userDefaults.getValue(for: isEnabledKey)
            }
        )
    }
    
    // MARK: Public Instance Interface
    
    public func setIsDisabled(basedOn isDisabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsDisabled {
            userDefaults.getValue(for: isDisabledKey)
        }
    }
    
    public func setIsEnabled(basedOn isEnabledKey: UserDefaultsKey<Bool>, userDefaults: UserDefaults = .standard) {
        setIsEnabled {
            userDefaults.getValue(for: isEnabledKey)
        }
    }
}

// MARK: - FeedbackGenerator.Feeback Definition

extension FeedbackGenerator {
    public enum Feedback: SynthesizedIdentifiable {
        case impact(Impact)
        case notification(Notification)
        case selection(Selection)
        
        // MARK: Factory Functions
        
        public static var selection: Feedback {
            .selection(.selectionChanged)
        }
    }
}

// MARK: - FeedbackGeneratorConvertible Extension

extension FeedbackGenerator.Feedback: FeedbackGeneratorConvertible {
    // MARK: Public Instance Interface
    
    public var asFeedback: FeedbackGenerator.Feedback {
        self
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

// MARK: - FeedbackGeneratorConvertible Extension

extension FeedbackGenerator.SemanticFeedback: FeedbackGeneratorConvertible {
    // MARK: Public Instance Interface
    
    public var asFeedback: FeedbackGenerator.Feedback {
        base
    }
}

// MARK: - FeedbackGeneratorConvertible Definition

public protocol FeedbackGeneratorConvertible {
    // MARK: Public Instance Interface
    
    var asFeedback: FeedbackGenerator.Feedback { get }
}

#endif
