//
//  Hash.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/30/22.
//

import Foundation

open class Hash {
    public let label: String
    
    public private(set) var dependencies: [Hash]
    public private(set) var dependents: [Hash]
    
    let labelHashValue: Int
    
    // MARK: Public Initialization
    
    public convenience init(_ label: String) {
        self.init(label: label, labelHashValue: label.hashValue)
    }
    
    public init(label: String, labelHashValue: Int) {
        self.label = label
        self.labelHashValue = labelHashValue
        
        dependencies = []
        dependents = []
    }
    
    // MARK: Abstract Public Instance Interface
    
    open var value: Int {
        fatalError("Must be implemented in subclass.")
    }
    
    open func dependencyDidUpdate() {
        fatalError("Must be implemented in subclass.")
    }
    
    open func update() {
        fatalError("Must be implemented in subclass.")
    }
    
    // MARK: Public Instance Interface
    
    public func addDependency(on dependency: Hash) {
        dependencies.append(dependency)
        dependency.dependents.append(self)
        
        dependencyDidUpdate()
    }
    
    public func addingDependency(on dependency: Hash) -> Self {
        addDependency(on: dependency)
        
        return self
    }
    
    // MARK: Internal Instance Interface
    
    func notifyDependentsOfDependencyUpdate() {
        for dependent in dependents {
            dependent.dependencyDidUpdate()
        }
    }
}
