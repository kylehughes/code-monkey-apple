//
//  DispatchQueue+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

import Foundation

extension DispatchQueue {
    // MARK: Root Queues
    
    public static let diskIO = DispatchQueueFactory.shared.makeRootQueue(subdomain: "disk-io")
    public static let networkIO = DispatchQueueFactory.shared.makeRootQueue(subdomain: "network-io")
    public static let ui = DispatchQueue.main
    public static let uiWork = DispatchQueueFactory.shared.makeRootQueue(subdomain: "ui-work")
    
    // MARK: Public Initialization
    
    public convenience init(
        label: ReverseDomainName,
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
}
