//
//  ZRelativeDirection.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/18/22.
//

public enum ZRelativeDirection: SynthesizedIdentifiable {
    case down
    case up
    
    // MARK: Public Instance Interface
    
    public var opposite: Self {
        switch self {
        case .down:
            return .up
        case .up:
            return .down
        }
    }
}
