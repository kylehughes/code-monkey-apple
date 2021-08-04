//
//  OrdinalMap.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 5/31/21.
//

public struct OrdinalMap<Key, OrderableType> where Key: Hashable, OrderableType: Orderable {
    public let largestOrdinal: OrderableType.Ordinal?
    public let nextOrdinal: OrderableType.Ordinal
    
    private var storage: [Key: OrderableType.Ordinal]
    
    // MARK: Public Initialization
    
    public init<Element>(
        orderedElements: [Element]
    )
    where
        Element: Identifiable,
        OrderableType: Identifiable,
        OrderableType.ID == Element.ID,
        OrderableType.ID == Key
    {
        largestOrdinal = 0 < orderedElements.count ? OrderableType.Ordinal(orderedElements.count) : nil
        nextOrdinal = (largestOrdinal ?? 0) + 1
        storage = [:]
        
        for (index, element) in orderedElements.enumerated() {
            storage[element.id] = OrderableType.Ordinal(index + 1)
        }
    }
    
    // MARK: Public Subscripts
    
    public subscript(key: Key) -> OrderableType.Ordinal? {
        storage[key]
    }
}
