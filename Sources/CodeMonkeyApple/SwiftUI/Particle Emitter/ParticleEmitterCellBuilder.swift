//
//  ParticleEmitterCellBuilder.swift
//  public
//
//  Created by Kyle Hughes on 6/27/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

@resultBuilder
public struct ParticleEmitterCellBuilder {
    // MARK: Public Static Interface
    
    public static func buildBlock(_ cells: CAEmitterCell...) -> [CAEmitterCell] {
        Array(cells)
    }
}

#endif
