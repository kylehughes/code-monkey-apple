//
//  ForEachWithIndex.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/4/22.
//

import SwiftUI

public struct ForEachWithIndex<Data, Content>
where
    Content: View,
    Data: RandomAccessCollection,
    Data.Index: Hashable
{
    private let content: (Data.Index, Data.Element) -> Content
    private let data: Data
    
    // MARK: Public Initialization
    
    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.init(data) { _, element in
            content(element)
        }
    }
    
    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Index, Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
}

// MARK: - View Extension

extension ForEachWithIndex: View {
    // MARK: View Body
    
    public var body: ForEach<[(Data.Index, Data.Element)], Data.Index, Content> {
        ForEach(Array(zip(data.indices, data)), id: \.0) { index, element in
            content(index, element)
        }
    }
}

extension ForEach where ID == Data.Index {
    // MARK: Public Initialization
    
    public init(_ data: Data, @ViewBuilder content: @escaping (ID, Data.Element) -> Content) {
        self.init(Array(zip(data.indices, data))) {
            content($0, $1)
        }
    }
}
