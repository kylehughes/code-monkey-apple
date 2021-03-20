//
//  DispatchQueueFactory.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 2/4/21.
//

import Foundation

public final class DispatchQueueFactory {
    public let domain: ReverseDomainName
    
    // MARK: Public Initialization
    
    public init(domain: ReverseDomainName) {
        self.domain = domain
    }
    
    // MARK: Public Instance Interface
    
    public func makeQueue(
        subdomain: String,
        targeting targetQueue: DispatchQueue,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        let targetDomain = ReverseDomainName(rawValue: targetQueue.label)
        let label = targetDomain.adding(subdomain: subdomain)
        
        return DispatchQueue(
            label: label,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: targetQueue
        )
    }
    
    public func makeOvercommittingRootQueue(
        subdomain: String,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        let label = domain.adding(subdomain: subdomain)
        
        return DispatchQueue(
            label: label,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: nil
        )
    }
    
    public func makeRootQueue(
        subdomain: String,
        qos: DispatchQoS = .unspecified,
        attributes: DispatchQueue.Attributes = [],
        autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit
    ) -> DispatchQueue {
        let label = domain.adding(subdomain: subdomain)
        
        return DispatchQueue(
            label: label,
            qos: qos,
            attributes: attributes,
            autoreleaseFrequency: autoreleaseFrequency,
            target: .global()
        )
    }
}

// MARK: - Internal Singleton

extension DispatchQueueFactory {
    static let shared = DispatchQueueFactory(domain: Info.id.adding(subdomain: "gcd"))
}
