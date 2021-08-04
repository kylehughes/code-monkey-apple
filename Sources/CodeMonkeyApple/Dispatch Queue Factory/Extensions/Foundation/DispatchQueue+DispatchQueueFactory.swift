//
//  DispatchQueue+DispatchQueueFactory.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

import Foundation

extension DispatchQueue {    
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
