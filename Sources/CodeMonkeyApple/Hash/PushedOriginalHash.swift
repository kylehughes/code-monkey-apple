//
//  PushedOriginalHash.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/30/22.
//

public final class PushedOriginalHash<Value>: Hash where Value: Hashable {
    private let get: () -> Value
    
    // MARK: Public Initialization
    
    public init(_ label: String, get: @escaping () -> Value) {
        self.get = get
        
        super.init(label: label, labelHashValue: label.hashValue)
    }
    
    // MARK: Hash Implementation
    
    public override var value: Int {
        `get`().hashValue
    }
    
    public override func addDependency(on dependency: Hash) {
        fatalError("Passthrough hash cannot support dependencies.")
    }
    
    public override func addingDependency(on dependency: Hash) -> Self {
        fatalError("Passthrough hash cannot support dependencies.")
    }
    
    public override func dependencyDidUpdate() {
        // NO-OP
    }
    
    public override func update() {
        notifyDependentsOfDependencyUpdate()
    }
}
