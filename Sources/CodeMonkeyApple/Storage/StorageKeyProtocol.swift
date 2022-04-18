//
//  StorageKeyProtocol.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/17/22.
//

public protocol StorageKeyProtocol: Identifiable {
    // MARK: Associated Types
    
    associatedtype Value: Storable
    
    // MARK: Instance Interface
    
    var defaultValue: Value { get }
    var id: String { get }
}
