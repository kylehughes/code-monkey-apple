//
//  Task+Background.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 10/10/21.
//

#if canImport(UIKit)
import UIKit
#endif

extension Task {
    // MARK: Public Static Interface
    
    @MainActor
    public static func runAsBackgroundable(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async -> Success
    ) async -> Success where Failure == Never {
        let task = Task(priority: priority, operation: operation)
        
        #if canImport(UIKit) && !os(watchOS)
        var backgroundTaskIdentifier: UIBackgroundTaskIdentifier! = nil
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: taskName) {
            task.cancel()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        
        let value = await task.value
        
        if backgroundTaskIdentifier != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        }
        
        return value
        #else
        return await task.value
        #endif
    }
    
    @MainActor
    public static func runAsBackgroundable(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async throws -> Success
    ) async throws -> Success where Failure == Error {
        let task = Task(priority: priority, operation: operation)
        
        #if canImport(UIKit) && !os(watchOS)
        var backgroundTaskIdentifier: UIBackgroundTaskIdentifier! = nil
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: taskName) {
            task.cancel()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        
        do {
            let value = try await task.value
            
            try Task<Never, Never>.checkCancellation()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
            
            return value
        } catch {
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
            
            throw error
        }
        #else
        return try await task.value
        #endif
    }
    
    @MainActor
    public static func runAsBackgroundableAndDetached(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async -> Success
    ) async -> Success where Failure == Never {
        let task = Task.detached(priority: priority, operation: operation)
        
        #if canImport(UIKit) && !os(watchOS)
        var backgroundTaskIdentifier: UIBackgroundTaskIdentifier! = nil
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: taskName) {
            task.cancel()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        
        let value = await task.value
        
        if backgroundTaskIdentifier != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        }
        
        return value
        #else
        return await task.value
        #endif
    }
    
    @MainActor
    public static func runAsBackgroundableAndDetached(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @escaping @Sendable () async throws -> Success
    ) async throws -> Success where Failure == Error {
        let task = Task.detached(priority: priority, operation: operation)
        
        #if canImport(UIKit) && !os(watchOS)
        var backgroundTaskIdentifier: UIBackgroundTaskIdentifier! = nil
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: taskName) {
            task.cancel()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        
        do {
            let value = try await task.value
            
            try Task<Never, Never>.checkCancellation()
            
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
            
            return value
        } catch {
            if backgroundTaskIdentifier != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
            
            throw error
        }
        #else
        return try await task.value
        #endif
    }
}

