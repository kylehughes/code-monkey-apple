//
//  ObservableObject+Propagate.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/16/22.
//

import Combine
import Foundation

extension ObservableObject where ObjectWillChangePublisher == ObservableObjectPublisher {
    // MARK: Public Instance Interface
    
    public func observeAndPropagateChanges<Other>(
        from other: Other,
        storedIn set: inout Set<AnyCancellable>
    ) where Other: ObservableObject {
        other
            .objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &set)
    }
    
    public func observeAndPropagateChangesForUI<Other>(
        from other: Other,
        storedIn set: inout Set<AnyCancellable>
    ) where Other: ObservableObject {
        other
            .objectWillChange
            .receiveForUI()
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &set)
    }
}
