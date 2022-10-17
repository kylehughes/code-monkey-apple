//
//  Global+Animation.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/17/22.
//

import SwiftUI

@MainActor
public func withAnimationOnMainActor<Result>(
    _ animation: Animation? = .default,
    _ body: () throws -> Result
) rethrows -> Result {
    try withAnimation(animation, body)
}
