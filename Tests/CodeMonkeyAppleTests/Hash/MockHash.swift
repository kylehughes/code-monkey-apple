//
//  MockHash.swift
//  CodeMonkeyAppleTests
//
//  Created by Kyle Hughes on 11/30/22.
//

import CodeMonkeyApple

final class MockHash: Hash {
    var _value: Int
    
    // MARK: Public Initialization
    
    public init(_ label: String, value: Int) {
        _value = value
        
        super.init(label: label, labelHashValue: label.hashValue)
    }
    
    // MARK: Hash Implementation
    
    public override var value: Int {
        _value
    }
    
    public override func dependencyDidUpdate() {
        // NO-OP
    }
    
    public override func update() {
        // NO-OP
    }
}
