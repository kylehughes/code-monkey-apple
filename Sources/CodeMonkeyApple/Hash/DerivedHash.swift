//
//  DerivedHash.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/30/22.
//

import Foundation

public final class DerivedHash: Hash {
    private var _value: Int {
        didSet {
            if oldValue != _value {
                notifyDependentsOfDependencyUpdate()
            }
        }
    }
    
    // MARK: Public Initialization
    
    public init(_ label: String) {
        let labelHashValue = label.hashValue
        
        _value = Self.calculate(for: labelHashValue, from: [])
        
        super.init(label: label, labelHashValue: labelHashValue)
    }
    
    // MARK: Private Static Interface
    
    private static func calculate(for labelHashValue: Int, from dependencies: [Hash]) -> Int {
        var hasher = Hasher()
        
        hasher.combine(labelHashValue)
        
        for dependency in dependencies {
            hasher.combine(dependency.value)
        }
        
        return hasher.finalize()
    }
    
    // MARK: Hash Implementation
    
    public override var value: Int {
        _value
    }
    
    public override func dependencyDidUpdate() {
        update()
    }
    
    public override func update() {
        let oldValue = value
        let newValue = Self.calculate(for: labelHashValue, from: dependencies)
        
        guard oldValue != newValue else {
            return
        }
        
        _value = newValue
    }
}
