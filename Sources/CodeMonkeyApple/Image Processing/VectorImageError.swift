//
//  VectorImageError.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 3/6/21.
//

import Accelerate

public enum VectorImageError: Error {
    case frameworkError(vImage_Error)
}

// MARK: - Global Functions

public func throwableVectorImageAction(action: () -> vImage_Error) throws {
    let error = action()
    
    guard error == kvImageNoError else {
        throw VectorImageError.frameworkError(error)
    }
}
