//
//  ParticleEmitterCell.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/27/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

public final class ParticleEmitterCell: CAEmitterCell {
    // MARK: Public Initialization
    
    public convenience init(_ setUp: (ParticleEmitterCell) -> Void) {
        self.init()
        
        setUp(self)
    }
    
    public override init() {
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Public Instance Interface
    
    public func copyAsType() -> ParticleEmitterCell {
        super.copy() as! ParticleEmitterCell
    }
    
    // MARK: Public Builder Interface
    
    @inlinable
    public func content(_ content: Content) -> Self {
        self.contents = content.image.cgImage
        
        return self
    }
    
    @inlinable
    public func birthRate(_ birthRate: Float) -> Self {
        self.birthRate = birthRate
        
        return self
    }
    
    @inlinable
    public func lifetime(_ lifetime: Float) -> Self {
        self.lifetime = lifetime
        
        return self
    }
    
    @inlinable
    public func scale(_ scale: CGFloat) -> Self {
        self.scale = scale
        
        return self
    }
    
    @inlinable
    public func scaleRange(_ scaleRange: CGFloat) -> Self {
        self.scaleRange = scaleRange
        
        return self
    }
    
    @inlinable
    public func scaleSpeed(_ scaleSpeed: CGFloat) -> Self {
        self.scaleSpeed = scaleSpeed
        
        return self
    }
    
    @inlinable
    public func velocity(_ velocity: CGFloat) -> Self {
        self.velocity = velocity
        
        return self
    }
    
    @inlinable
    public func velocityRange(_ velocityRange: CGFloat) -> Self {
        self.velocityRange = velocityRange
        
        return self
    }
    
    @inlinable
    public func emissionLongitude(_ emissionLongitude: CGFloat) -> Self {
        self.emissionLongitude = emissionLongitude
        
        return self
    }
    
    @inlinable
    public func emissionLatitude(_ emissionLatitude: CGFloat) -> Self {
        self.emissionLatitude = emissionLatitude
        
        return self
    }
    
    @inlinable
    public func emissionRange(_ emissionRange: CGFloat) -> Self {
        self.emissionRange = emissionRange
        
        return self
    }
    
    @inlinable
    public func spin(_ spin: CGFloat) -> Self {
        self.spin = spin
        
        return self
    }
    
    @inlinable
    public func spinRange(_ spinRange: CGFloat) -> Self {
        self.spinRange = spinRange
        
        return self
    }
    
    @inlinable
    public func color(_ color: UIColor) -> Self {
        self.color = color.cgColor
        
        return self
    }
    
    @inlinable
    public func xAcceleration(_ xAcceleration: CGFloat) -> Self {
        self.xAcceleration = xAcceleration
        
        return self
    }
    
    @inlinable
    public func yAcceleration(_ yAcceleration: CGFloat) -> Self {
        self.yAcceleration = yAcceleration
        
        return self
    }
    
    @inlinable
    public func zAcceleration(_ zAcceleration: CGFloat) -> Self {
        self.zAcceleration = zAcceleration
        
        return self
    }
    
    @inlinable
    public func alphaSpeed(_ alphaSpeed: Float) -> Self {
        self.alphaSpeed = alphaSpeed
        
        return self
    }
    
    @inlinable
    public func alphaRange(_ alphaRange: Float) -> Self {
        self.alphaRange = alphaRange
        
        return self
    }
}

// MARK: - ParticleEmitterCell.Content Definition

extension ParticleEmitterCell {
    public enum Content {
        case image(UIImage)
        case circle(CGFloat)
        
        // MARK: Public Instance Inteface
        
        public var image: UIImage {
            switch self {
            case let .image(image):
                return image
            case let .circle(radius):
                let size = CGSize(width: radius * 2, height: radius * 2)
                return UIGraphicsImageRenderer(size: size).image { context in
                    context.cgContext.setFillColor(UIColor.white.cgColor)
                    context.cgContext.addPath(CGPath(ellipseIn: CGRect(origin: .zero, size: size), transform: nil))
                    context.cgContext.fillPath()
                }
            }
        }
    }
}

#endif
