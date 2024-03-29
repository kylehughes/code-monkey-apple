//
//  StorageKeyObserver.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/13/22.
//

import Foundation

/// This class, and the `Storage` functions it relies upon, implement the two known ways to observe `UserDefaults` and
/// `NSUbiquitousKeyValueStore`. It is likely that other `Storage` implementations can be written under the same
/// interface but that is not what it is optimized for. This lets us use `StoredValue` with any type of `Storage` and
/// simplifies many callsites that previously had to be duplicated between those two known `Storage` implementations.
public class StorageKeyObserver<Key>: NSObject, ObservableObject where Key: StorageKeyProtocol {
    public let key: Key
    public let storage: Storage
    
    private var context: Int
    
    // MARK: Public Initialization
    
    public init(storage: Storage, key: Key) {
        self.storage = storage
        self.key = key
        
        context = 0
        
        super.init()
        
        storage.register(observer: self, for: key, with: &context) { [weak self] in
            self?.objectWillChange()
        }
    }
    
    deinit {
        storage.deregister(observer: self, for: key, with: &context)
    }
    
    // MARK: Public Instance Interface
    
    public var value: Key.Value {
        get {
            storage.get(key)
        }
        set {
            objectWillChange.send()
            
            storage.set(key, to: newValue)
        }
    }
    
    // MARK: NSObject Implementation
    
    public override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        objectWillChange()
    }
    
    // MARK: Private Instance Interface
    
    private func objectWillChange() {
        Task {
            await MainActor.run {
                objectWillChange.send()
            }
        }
    }
}
