//
//  CodableFile.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/16/23.
//

import Foundation

public final class CodableFile<Value> where Value: Codable {
    public private(set) var value: Value {
        didSet {
            try? encoder.encode(value).write(to: url)
        }
    }
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    private let fileManager: FileManager
    private let url: URL
    
    // MARK: Public Initialization
    
    public init(
        url: URL,
        defaultValue: @autoclosure () -> Value,
        decoder: JSONDecoder = .default,
        encoder: JSONEncoder = .default,
        fileManager: FileManager = .default
    ) {
        self.url = url
        self.decoder = decoder
        self.encoder = encoder
        self.fileManager = fileManager
        
        do {
            if fileManager.fileExists(atPath: url.path) {
                value = try decoder.decode(Value.self, from: Data(contentsOf: url))
            } else {
                let defaultValue = defaultValue()
                
                try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
                try fileManager.createFile(atPath: url.path, contents: encoder.encode(defaultValue))
                
                value = defaultValue
            }
        } catch {
            value = defaultValue()
        }
    }
    
    // MARK: Public Instance Interface
    
    public func modify(_ perform: (inout Value) -> Void) {
        perform(&value)
    }
}
