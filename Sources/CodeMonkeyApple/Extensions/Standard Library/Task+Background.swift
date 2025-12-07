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
    // MARK: Creating Infallible Backgroundable Tasks
    
    /// Runs the given nonthrowing operation asynchronously as part of a new top-level task on behalf of the current
    /// actor. The task will be registered with the system as a background task
    /// (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// - Parameter taskName: The name to display in the debugger when viewing the background task. If you specify `nil`
    /// for this parameter, the method generates a name based on the name of the calling function or method.
    /// - Parameter priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    /// - Parameter operation: The operation to perform.
    @discardableResult
    @inlinable
    public static func backgroundable(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture @_inheritActorContext operation: @Sendable @escaping () async -> Success
    ) -> Task<Success, Failure> where Failure == Never {
        backgroundable(named: taskName, priority: priority, factory: .attached, operation: operation)
    }
    
    /// Runs the given nonthrowing operation asynchronously as part of a new top-level task. The task will be registered
    /// with the system as a background task (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// - Parameter taskName: The name to display in the debugger when viewing the background task. If you specify `nil`
    /// for this parameter, the method generates a name based on the name of the calling function or method.
    /// - Parameter priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    /// - Parameter operation: The operation to perform.
    @discardableResult
    @inlinable
    public static func backgroundableDetached(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping () async -> Success
    ) -> Task<Success, Failure> where Failure == Never {
        backgroundable(named: taskName, priority: priority, factory: .detached, operation: operation)
    }
    
    // MARK: Creating Fallible Backgroundable Tasks
    
    /// Runs the given throwing operation asynchronously as part of a new top-level task on behalf of the current
    /// actor. The task will be registered with the system as a background task
    /// (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// - Parameter taskName: The name to display in the debugger when viewing the background task. If you specify `nil`
    /// for this parameter, the method generates a name based on the name of the calling function or method.
    /// - Parameter priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    /// - Parameter operation: The operation to perform.
    @discardableResult
    @inlinable
    public static func backgroundable(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture @_inheritActorContext operation: @Sendable @escaping () async throws -> Success
    ) -> Task<Success, Failure> where Failure == Error {
        backgroundable(named: taskName, priority: priority, factory: .attached, operation: operation)
    }
    
    /// Runs the given throwing operation asynchronously as part of a new top-level task. The task will be registered
    /// with the system as a background task (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// - Parameter taskName: The name to display in the debugger when viewing the background task. If you specify `nil`
    /// for this parameter, the method generates a name based on the name of the calling function or method.
    /// - Parameter priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    /// - Parameter operation: The operation to perform.
    @discardableResult
    @inlinable
    public static func backgroundableDetached(
        named taskName: String? = nil,
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task<Success, Failure> where Failure == Error {
        backgroundable(named: taskName, priority: priority, factory: .detached, operation: operation)
    }

    // MARK: Internal Instance Interface
    
    /// Runs the given nonthrowing operation asynchronously in the manor of the given factory. The task will be
    /// registered with the system as a background task
    /// (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// This is the helper function to allow our `Task.init` and `Task.detached`-oriented functions to share their
    /// implementation.
    ///
    /// - Parameter taskName: The name to display in the debugger when viewing the background task. If you specify `nil`
    /// for this parameter, the method generates a name based on the name of the calling function or method.
    /// - Parameter priority: The priority of the task. Pass `nil` to use the priority from `Task.currentPriority`.
    /// - Parameter factory: The way to create the `Task`.
    /// - Parameter operation: The operation to perform.
    @usableFromInline
    static func backgroundable(
        named taskName: String?,
        priority: TaskPriority?,
        factory: Factory,
        operation: @Sendable @escaping () async -> Success
    ) -> Task<Success, Failure> where Failure == Never {
        #if canImport(UIKit) && !os(watchOS)
        return factory.makeTask(priority: priority) {
            var mutableBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
            
            withUnsafeCurrentTask { task in
                mutableBackgroundTaskIdentifier = beginBackgroundTask(withName: taskName) {
                    // We know that cancelling the task will also end the background task
                    task?.cancel()
                }
            }
                        
            let backgroundTaskIdentifier = mutableBackgroundTaskIdentifier
            
            return await withTaskCancellationHandler {
                let value = await operation()
                
                // We know that the background task will be ended if the task is cancelled
                if not(Task<Never, Never>.isCancelled) {
                    endBackgroundTask(backgroundTaskIdentifier)
                }
                
                return value
            } onCancel: {
                endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        #else
        return factory.makeTask(priority: priority, operation: operation)
        #endif
    }
    
    /// Runs the given throwing operation asynchronously in the manor of the given factory. The task will be
    /// registered with the system as a background task
    /// (see: `UIApplication.beginBackgroundTask(withName, expirationHandler:)`).
    ///
    /// The lifetime of the registered background task will be automatically managed. The task will be cancelled if the
    /// system cancels the background task.
    ///
    /// This is the helper function to allow our `Task.init` and `Task.detached`-oriented functions to share their
    /// implementation.
    @usableFromInline
    static func backgroundable(
        named taskName: String?,
        priority: TaskPriority?,
        factory: Factory,
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task<Success, Failure> where Failure == Error {
        #if canImport(UIKit) && !os(watchOS)
        return factory.makeTask(priority: priority) {
            var mutableBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
            
            withUnsafeCurrentTask { task in
                mutableBackgroundTaskIdentifier = beginBackgroundTask(withName: taskName) {
                    // We know that cancelling the task will also end the background task
                    task?.cancel()
                }
            }
                        
            let backgroundTaskIdentifier = mutableBackgroundTaskIdentifier
            
            return try await withTaskCancellationHandler {
                let value = try await operation()
                
                // We know that the background task will be ended if the task is cancelled
                if not(Task<Never, Never>.isCancelled) {
                    endBackgroundTask(backgroundTaskIdentifier)
                }
                
                return value
            } onCancel: {
                endBackgroundTask(backgroundTaskIdentifier)
            }
        }
        #else
        return factory.makeTask(priority: priority, operation: operation)
        #endif
    }
}

// MARK: - Structured Concurrency Workarounds

#if canImport(UIKit) && !os(watchOS)

private func beginBackgroundTask(expirationHandler handler: (() -> Void)? = nil) -> UIBackgroundTaskIdentifier {
    UIApplication.shared.beginBackgroundTask(expirationHandler: handler)
}

private func beginBackgroundTask(
    withName taskName: String?,
    expirationHandler handler: (() -> Void)? = nil
) -> UIBackgroundTaskIdentifier {
    UIApplication.shared.beginBackgroundTask(withName: taskName, expirationHandler: handler)
}

private func endBackgroundTask(_ identifier: UIBackgroundTaskIdentifier) {
    guard identifier != .invalid else {
        return
    }
    
    UIApplication.shared.endBackgroundTask(identifier)
}

#endif

// MARK: - TaskFactory Definition

extension Task {
    @usableFromInline
    enum Factory {
        case attached
        case detached
        
        @usableFromInline
        func makeTask(
            priority: TaskPriority?,
            operation: sending @escaping () async -> Success
        ) -> Task<Success, Failure> where Failure == Never {
            switch self {
            case .attached: Task(priority: priority, operation: operation)
            case .detached: Task.detached(priority: priority, operation: operation)
            }
        }
        
        @usableFromInline
        func makeTask(
            priority: TaskPriority?,
            operation: sending @escaping () async throws -> Success
        ) -> Task<Success, Failure> where Failure == any Error {
            switch self {
            case .attached: Task(priority: priority, operation: operation)
            case .detached: Task.detached(priority: priority, operation: operation)
            }
        }
    }
}
