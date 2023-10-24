//
//  Loadable.swift
//  Save My Streak
//
//  Created by Kyle Hughes on 4/23/23.
//

@dynamicMemberLookup
public enum Loadable<Value> {
    case loaded(Value)
    case loading
    
    // MARK: Public Subscript Interface
    
    @inlinable
    public subscript<ChildValue>(dynamicMember keyPath: KeyPath<Value, ChildValue>) -> Loadable<ChildValue> {
        switch self {
        case let .loaded(value):
            return .loaded(value[keyPath: keyPath])
        case .loading:
            return .loading
        }
    }
    
    // MARK: Public Instance Interface
    
    @inlinable
    public var isLoaded: Bool {
        switch self {
        case .loaded:
            return true
        case .loading:
            return false
        }
    }
    
    @inlinable
    public var isLoading: Bool {
        switch self {
        case .loaded:
            return false
        case .loading:
            return true
        }
    }
    
    @inlinable
    public func map<Other>(_ transform: (Value) throws -> Other) rethrows -> Loadable<Other> {
        switch self {
        case let .loaded(value):
            return try .loaded(transform(value))
        case .loading:
            return .loading
        }
    }
    
    @inlinable
    public func resolve(replacingLoadingWith replacement: @autoclosure () -> Value) -> Value {
        switch self {
        case let .loaded(value):
            return value
        case .loading:
            return replacement()
        }
    }
}

// MARK: - Equatable Extension

extension Loadable: Equatable where Value: Equatable {
    // NO-OP
}

// MARK: - Extension where Value == Void

extension Loadable where Value == Void {
    // MARK: Public Static Interface
    
    @inlinable
    public static var loaded: Self {
        .loaded(())
    }
}
