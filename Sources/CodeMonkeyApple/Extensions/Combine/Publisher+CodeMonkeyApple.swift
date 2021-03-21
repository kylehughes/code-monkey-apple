//
//  Publisher+CodeMonkeyApple.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 1/24/21.
//

import Combine
import Foundation

extension Publisher {
    // MARK: Mapping Elements
    
    public func mapToNil<NewOutput>() -> Publishers.Map<Self, Optional<NewOutput>> {
        map { _ in
            .none
        }
    }
    
    public func mapToOptional() -> Publishers.Map<Self, Optional<Output>> {
        map(Optional.init)
    }
    
    // MARK: Filtering Elements
    
    public func skipNil<UnwrappedOutput>(
    ) -> Publishers.CompactMap<Self, UnwrappedOutput> where Output == Optional<UnwrappedOutput> {
        compactMap { $0 }
    }
    
    // MARK: Specifying Schedulers
    
    public func doWorkForUIAndReceiveForUI<WorkPublisher>(
        _ publisherProvider: (Publishers.ReceiveOn<Self, DispatchQueue>) -> WorkPublisher
    ) -> Publishers.ReceiveOn<WorkPublisher, DispatchQueue> where WorkPublisher: Publisher {
        publisherProvider(receiveForWorkForUI())
            .receiveForUI()
    }
    
    public func doWorkForUIAndReceiveForUI<WorkPublisher>(
        _ publisherProvider: (Publishers.ReceiveOn<Self, DispatchQueue>) -> WorkPublisher
    ) -> Publishers.ReceiveOn<Publishers.RemoveDuplicates<WorkPublisher>, DispatchQueue>
    where
        WorkPublisher: Publisher,
        WorkPublisher.Output: Equatable
    {
        publisherProvider(receiveForWorkForUI())
            .receiveForUI()
    }
    
    public func receiveForUI() -> Publishers.ReceiveOn<Self, DispatchQueue>  {
        receive(on: DispatchQueue.ui)
    }
    
    public func receiveForWorkForUI() -> Publishers.ReceiveOn<Self, DispatchQueue>  {
        receive(on: DispatchQueue.uiWork)
    }
}

// MARK: - Extension where Output is Equatable

extension Publisher where Output: Equatable {
    // MARK: Specifying Schedulers
    
    public func receiveForUI() -> Publishers.ReceiveOn<Publishers.RemoveDuplicates<Self>, DispatchQueue> {
        removeDuplicates()
            .receiveForUI()
    }
}
