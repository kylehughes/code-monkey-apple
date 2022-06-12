//
//  Task+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/24/21.
//

import Foundation

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension Task where Success == Never, Failure == Never {
    // MARK: Public Static Interface
    
    public static func sleep(milliseconds: Double) async throws {
        try await sleep(nanoseconds: UInt64(milliseconds * 1_000_000))
    }
    
    public static func sleep(seconds: TimeInterval) async throws {
        try await sleep(milliseconds: seconds * 1_000)
    }
    
    public static func sleepUnlessCancelled(nanoseconds: UInt64) async throws {
        guard not(Task.isCancelled) else {
            return
        }
        
        try await sleep(nanoseconds: nanoseconds)
    }
    
    public static func sleepUnlessCancelled(milliseconds: TimeInterval) async throws {
        try await sleepUnlessCancelled(nanoseconds: UInt64(milliseconds) * 1_000_000)
    }

    public static func sleepUnlessCancelled(seconds: TimeInterval) async throws {
        try await sleepUnlessCancelled(milliseconds: seconds * 1_000)
    }
}
