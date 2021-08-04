//
//  ParticleEmitter.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/27/21.
//

import SwiftUI

#if canImport(UIKit)

import UIKit

public struct ParticleEmitter {
    public private(set) var cells: [CAEmitterCell]
    public private(set) var mode: CAEmitterLayerEmitterMode
    public private(set) var position: CGPoint
    public private(set) var renderMode: CAEmitterLayerRenderMode
    public private(set) var seed: UInt32
    public private(set) var shape: CAEmitterLayerEmitterShape
    public private(set) var size: CGSize
    
    // MARK: Public Initialization

    public init(@ParticleEmitterCellBuilder _ content: () -> [CAEmitterCell]) {
        self.init(cells: content())
    }
    
    public init(@ParticleEmitterCellBuilder _ content: () -> CAEmitterCell) {
        self.init(cells: [content()])
    }
    
    public init(
        cells: [CAEmitterCell] = [],
        mode: CAEmitterLayerEmitterMode = .volume,
        position: CGPoint = .zero,
        renderMode: CAEmitterLayerRenderMode = .unordered,
        seed: UInt32 = .random(in: UInt32.min...UInt32.max),
        shape: CAEmitterLayerEmitterShape = .point,
        size: CGSize = .zero
    ) {
        self.cells = cells
        self.mode = mode
        self.position = position
        self.renderMode = renderMode
        self.seed = seed
        self.shape = shape
        self.size = size
    }
    
    // MARK: Public Instance Interface
    
    public func emitterMode(_ mode: CAEmitterLayerEmitterMode) -> Self {
        var copy = self
        copy.mode = mode
        
        return copy
    }
    
    public func emitterPosition(_ position: CGPoint) -> Self {
        var copy = self
        copy.position = position
        
        return copy
    }
    
    public func emitterRenderMode(_ renderMode: CAEmitterLayerRenderMode) -> Self {
        var copy = self
        copy.renderMode = renderMode
        
        return copy
    }
    
    public func emitterSeed(_ seed: UInt32) -> Self {
        var copy = self
        copy.seed = seed
        
        return copy
    }
    
    public func emitterShape(_ shape: CAEmitterLayerEmitterShape) -> Self {
        var copy = self
        copy.shape = shape
        
        return copy
    }
    
    public func emitterSize(_ size: CGSize) -> Self {
        var copy = self
        copy.size = size
        
        return copy
    }
}

// MARK: - UIViewRepresentable Extension

extension ParticleEmitter: UIViewRepresentable {
    // MARK: Public Instance Interface
    
    public func makeUIView(context: Context) -> BackingUIView {
        let uiView = BackingUIView()
        uiView.emit(
            cells: cells,
            mode: mode,
            position: position,
            renderMode: renderMode,
            seed: seed,
            shape: shape,
            size: size
        )
        
        return uiView
    }
    
    public func updateUIView(_ uiView: BackingUIView, context: UIViewRepresentableContext<ParticleEmitter>) {
        uiView.emit(
            cells: cells,
            mode: mode,
            position: position,
            renderMode: renderMode,
            seed: seed,
            shape: shape,
            size: size
        )
    }
}

// MARK: - ParticleEmitter.BackingView Definition

extension ParticleEmitter {
    public final class BackingUIView: UIView {
        private let particleEmitter: CAEmitterLayer
        
        // MARK: Internal Initialization
        
        internal init() {
            particleEmitter = CAEmitterLayer()
            
            super.init(frame: .zero)
            
            layer.addSublayer(particleEmitter)
        }
        
        internal required init?(coder: NSCoder) {
            particleEmitter = CAEmitterLayer()
            
            super.init(coder: coder)
            
            layer.addSublayer(particleEmitter)
        }
        
        // MARK: Internal Instance Interface
        
        internal func emit(
            cells: [CAEmitterCell],
            mode: CAEmitterLayerEmitterMode,
            position: CGPoint,
            renderMode: CAEmitterLayerRenderMode,
            seed: UInt32,
            shape: CAEmitterLayerEmitterShape,
            size: CGSize
        ) {
            particleEmitter.emitterCells = cells
            particleEmitter.emitterMode = mode
            particleEmitter.emitterPosition = position
            particleEmitter.emitterShape = shape
            particleEmitter.emitterSize = size
            particleEmitter.renderMode = renderMode
            particleEmitter.seed = seed
        }
    }
}

#endif
