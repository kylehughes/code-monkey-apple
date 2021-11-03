//
//  VersionableWrapper.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 11/2/21.
//

public protocol VersionableWrapper {
    // MARK: Associated Types

    associatedtype Version: CodeMonkeyApple.Version
    
    // MARK: Instance Interface
    
    var version: Version { get }
}
