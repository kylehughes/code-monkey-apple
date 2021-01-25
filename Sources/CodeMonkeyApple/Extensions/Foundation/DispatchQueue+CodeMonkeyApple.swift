//
//  DispatchQueue+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

import Foundation

extension DispatchQueue {
    // MARK: Root Queues
    
    public static let ui = DispatchQueue.main
    public static let uiWorker = makeRootQueue(subdomain: "ui-worker", qos: .default)
    
    // MARK: Private Static Properties
    
    private static let baseQueueIdentifier = Info.bundleIdentifier.adding(subdomain: "gcd")
    
    // MARK: Public Initialization
    
    public convenience init(
        label: ReverseDomainNameIdentifier,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit,
        target: DispatchQueue? = nil
    ) {
        self.init(
            label: label.rawValue,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: target
        )
    }
    
    // MARK: Queue Factory Interface
    
    public static func makeQueue(
        id: ReverseDomainNameIdentifier,
        targeting rootQueue: RootQueue,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        DispatchQueue(
            label: id,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: rootQueue.object
        )
    }
    
    public static func makeQueue(
        subdomain: String,
        targeting rootQueue: RootQueue,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        makeQueue(
            id: baseQueueIdentifier.adding(subdomain: subdomain),
            targeting: rootQueue,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency
        )
    }
    
    public static func makeRootQueue(
        id: ReverseDomainNameIdentifier,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        DispatchQueue(
            label: id,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: nil
        )
    }
    
    public static func makeRootQueue(
        subdomain: String,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        makeRootQueue(
            id: baseQueueIdentifier.adding(subdomain: subdomain),
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency
        )
    }
}

// MARK: - DispatchQueue.RootQueue Definition

extension DispatchQueue {
    public enum RootQueue {
        case ui
        case uiWorker
        
        // MARK: Public Static Interface
        
        public var object: DispatchQueue {
            switch self {
            case .ui:
                return .ui
            case .uiWorker:
                return .uiWorker
            }
        }
    }
}
