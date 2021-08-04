//
//  Task+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/24/21.
//

import Foundation

@available(iOS 15, macOS 15, tvOS 15, watchOS 8, *)
extension Task where Success == Never, Failure == Never {
    // MARK: Public Static Interface
    
    public static func sleep(milliseconds: Double) async {
        await sleep(UInt64(milliseconds * 1_000_000))
    }
    
    public static func sleep(seconds: TimeInterval) async {
        await sleep(milliseconds: seconds * 1_000)
    }
    
    public static func sleepUnlessCancelled(_ duration: UInt64) async {
        guard not(Task.isCancelled) else {
            return
        }
        
        await Task.sleep(duration)
    }
    
    public static func sleepUnlessCancelled(milliseconds: TimeInterval) async {
        await Task.sleepUnlessCancelled(UInt64(milliseconds) * 1_000_000)
    }

    public static func sleepUnlessCancelled(seconds: TimeInterval) async {
        await Task.sleepUnlessCancelled(milliseconds: seconds * 1_000)
    }
}
