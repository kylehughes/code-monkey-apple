//
//  Publisher+Assign.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 8/29/22.
//

import Combine
import Foundation
import SwiftUI

// MARK: - Extension where Output equals Never

extension Publisher where Self.Failure == Never {
    // MARK: Public Instance Interface
    
    public func assignWithoutRetaining<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
    
    public func assignWithoutRetaining<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root,
        animatedWith animation: Animation
    ) -> AnyCancellable where Root: AnyObject {
        sink(animatedWith: animation) { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
    
    public func sink(
        animatedWith animation: Animation,
        receiveValue: @escaping ((Self.Output) -> Void)
    ) -> AnyCancellable {
        sink { value in
            withAnimation(animation) {
                receiveValue(value)
            }
        }
    }
}
