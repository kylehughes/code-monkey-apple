//
//  Publisher+Propagate.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/18/22.
//

import Combine
import Foundation

extension Publisher {
    // MARK: Public Instance Interface
    
    @inlinable
    public func mapToObservableObjectWillChange<Nested>(
        at keyPath: KeyPath<Output, Nested>
    ) -> some Publisher<Nested.ObjectWillChangePublisher.Output, Failure> where
        Nested: ObservableObject,
        Nested.ObjectWillChangePublisher == ObservableObjectPublisher,
        Nested.ObjectWillChangePublisher.Failure == Failure
    {
        mapToNestedPublisher(keyPath.appending(path: \.objectWillChange))
    }
    
    @inlinable
    public func mapToNestedPublisher<Nested>(
        _ keyPath: KeyPath<Output, Nested>
    ) -> some Publisher<Nested.Output, Failure> where Nested: Publisher, Nested.Failure == Failure {
        map(keyPath)
            .switchToLatest()
    }
    
    @inlinable
    public func mapToObservableObjectDidChange<Nested>(
        _ keyPath: KeyPath<Output, Nested>
    ) -> some Publisher<Nested, Failure> where
        Nested: ObservableObject,
        Nested.ObjectWillChangePublisher == ObservableObjectPublisher,
        Nested.ObjectWillChangePublisher.Failure == Failure
    {
        map { object in
            let nestedObject = object[keyPath: keyPath]
            
            return nestedObject[keyPath: \.objectWillChange]
                .map { nestedObject }
        }
        .switchToLatest()
        // We need to skip ahead one tick to actually get the new value that triggered the `objectWillChange` stream.
        .receive(on: RunLoop.current)
    }
}
