//
//  TaskExecutor.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 9/26/22.
//

import Foundation

/// Actor that can constrain the number of concurrent `Task`s being executed, like
/// `OperationQueue` with `maxConcurrentOperationCount`.
public actor TaskExecutor<Success> {
    private let maxConcurrentTaskCount: Int
    
    private var numberOfRunningTasks: Int
    private var pendingContinuations: [UnsafeContinuation<Void, Never>]
    
    // MARK: Public Initialization
    
    public init(for urlSession: URLSession) {
        self.init(maxConcurrentTaskCount: urlSession.configuration.httpMaximumConnectionsPerHost)
    }
    
    public init(maxConcurrentTaskCount: Int) {
        self.maxConcurrentTaskCount = maxConcurrentTaskCount
        
        numberOfRunningTasks = 0
        pendingContinuations = []
    }
    
    // MARK: Public Instance Interface
    
    public func submit(
        priority: TaskPriority? = nil,
        _ task: @escaping () async throws -> Success
    ) -> Task<Success, any Error> {
        Task(priority: priority) {
            try await submit(task)
        }
    }
    
    public func submit(_ task: @escaping () async throws -> Success) async throws -> Success {
        if maxConcurrentTaskCount <= numberOfRunningTasks {
            await withUnsafeContinuation {
                pendingContinuations.append($0)
            }
        }
        
        numberOfRunningTasks += 1
        
        defer {
            numberOfRunningTasks -= 1
            
            if not(pendingContinuations.isEmpty) {
                pendingContinuations.removeFirst().resume()
            }
        }
        
        return try await task()
    }
}
