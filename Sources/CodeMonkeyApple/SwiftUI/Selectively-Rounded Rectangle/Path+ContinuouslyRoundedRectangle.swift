//
//  Path+SuperHeadache.swift
//  Common
//
//  Created by Kyle Hughes on 8/21/21.
//

import CoreGraphics
import SwiftUI

private let coefficient0: CGFloat = 0.04641
private let coefficient1: CGFloat = 0.08715
private let coefficient2: CGFloat = 0.13357
private let coefficient3: CGFloat = 0.16296
private let coefficient4: CGFloat = 0.21505
private let coefficient5: CGFloat = 0.290086
private let coefficient6: CGFloat = 0.32461
private let coefficient7: CGFloat = 0.37801
private let coefficient8: CGFloat = 0.44576
private let coefficient9: CGFloat = 0.6074
private let coefficient10: CGFloat = 0.77037

private let ellipseCoefficient: CGFloat = 1.28195

extension Path {
    // MARK: Public Static Interface
    
    public static func continuouslyRoundedRectangle(in rect: CGRect, with cornerRadius: CGFloat) -> Path {
        continuouslyRoundedRectangle(in: rect, with: CornerRadii(cornerRadius))
    }
    
    public static func continuouslyRoundedRectangle(in rect: CGRect, with cornerRadii: CornerRadii) -> Path {
        let cornerRadii = minimumCornerRadii(for: rect, with: cornerRadii)
        
        var path = Path()
        
        // MARK: Top Right Point 1 Points
        
        let topRightP1 = CGPoint(
            x: rect.width - cornerRadii.topRight * ellipseCoefficient,
            y: rect.origin.y
        )
        let topRightP1CP1 = CGPoint(
            x: topRightP1.x + cornerRadii.topRight * coefficient8,
            y: topRightP1.y
        )
        let topRightP1CP2 = CGPoint(
            x: topRightP1.x + cornerRadii.topRight * coefficient9,
            y: topRightP1.y + cornerRadii.topRight * coefficient0
        )
        
        // MARK: Top Right Point 2 Points

        let topRightP2 = CGPoint(
            x: topRightP1.x + cornerRadii.topRight * coefficient10,
            y: topRightP1.y + cornerRadii.topRight * coefficient2
        )
        let topRightP2CP1 = CGPoint(
            x: topRightP2.x + cornerRadii.topRight * coefficient3,
            y: topRightP2.y + cornerRadii.topRight * coefficient1
        )
        let topRightP2CP2 = CGPoint(
            x: topRightP2.x + cornerRadii.topRight * coefficient5,
            y: topRightP2.y + cornerRadii.topRight * coefficient4
        )
        
        // MARK: Top Right Point 3 Points
        
        let topRightP3 = CGPoint(
            x: topRightP2.x + cornerRadii.topRight * coefficient7,
            y: topRightP2.y + cornerRadii.topRight * coefficient7
        )
        let topRightP3CP1 = CGPoint(
            x: topRightP3.x + cornerRadii.topRight * coefficient1,
            y: topRightP3.y + cornerRadii.topRight * coefficient3
        )
        let topRightP3CP2 = CGPoint(
            x: topRightP3.x + cornerRadii.topRight * coefficient2,
            y: topRightP3.y + cornerRadii.topRight * coefficient6
        )
        
        // MARK: Top Right Point 4
        
        let topRightP4 = CGPoint(
            x: topRightP3.x + cornerRadii.topRight * coefficient2,
            y: topRightP3.y + cornerRadii.topRight * coefficient10
        )
        
        // MARK: Bottom Right Point 1 Points
        
        let bottomRightP1 = CGPoint(
            x: rect.width,
            y: rect.height - cornerRadii.bottomRight * ellipseCoefficient
        )
        let bottomRightP1CP1 = CGPoint(
            x: bottomRightP1.x,
            y: bottomRightP1.y + cornerRadii.bottomRight * coefficient8
        )
        let bottomRightP1CP2 = CGPoint(
            x: bottomRightP1.x - cornerRadii.bottomRight * coefficient0,
            y: bottomRightP1.y + cornerRadii.bottomRight * coefficient9
        )
        
        // MARK: Bottom Right Point 2 Points
        
        let bottomRightP2 = CGPoint(
            x: bottomRightP1.x - cornerRadii.bottomRight * coefficient2,
            y: bottomRightP1.y + cornerRadii.bottomRight * coefficient10
        )
        let bottomRightP2CP1 = CGPoint(
            x: bottomRightP2.x - cornerRadii.bottomRight * coefficient1,
            y: bottomRightP2.y + cornerRadii.bottomRight * coefficient3
        )
        let bottomRightP2CP2 = CGPoint(
            x: bottomRightP2.x - cornerRadii.bottomRight * coefficient4,
            y: bottomRightP2.y + cornerRadii.bottomRight * coefficient5
        )
        
        // MARK: Bottom Right Point 3 Points
        
        let bottomRightP3 = CGPoint(
            x: bottomRightP2.x - cornerRadii.bottomRight * coefficient7,
            y: bottomRightP2.y + cornerRadii.bottomRight * coefficient7
        )
        let bottomRightP3CP1 = CGPoint(
            x: bottomRightP3.x - cornerRadii.bottomRight * coefficient3,
            y: bottomRightP3.y + cornerRadii.bottomRight * coefficient1
        )
        let bottomRightP3CP2 = CGPoint(
            x: bottomRightP3.x - cornerRadii.bottomRight * coefficient6,
            y: bottomRightP3.y + cornerRadii.bottomRight * coefficient2
        )
        
        // MARK: Bottom Right Point 4
        
        let bottomRightP4 = CGPoint(
            x: bottomRightP3.x - cornerRadii.bottomRight * coefficient10,
            y: bottomRightP3.y + cornerRadii.bottomRight * coefficient2
        )
        
        // MARK: Bottom Left Point 1 Points
        
        let bottomLeftP1 = CGPoint(
            x: rect.origin.x + cornerRadii.bottomLeft * ellipseCoefficient,
            y: rect.height
        )
        let bottomLeftP1CP1 = CGPoint(
            x: bottomLeftP1.x - cornerRadii.bottomLeft * coefficient8,
            y: bottomLeftP1.y
        )
        let bottomLeftP1CP2 = CGPoint(
            x: bottomLeftP1.x - cornerRadii.bottomLeft * coefficient9,
            y: bottomLeftP1.y - cornerRadii.bottomLeft * coefficient0
        )
        
        // MARK: Bottom Left Point 2 Points
        
        let bottomLeftP2 = CGPoint(
            x: bottomLeftP1.x - cornerRadii.bottomLeft * coefficient10,
            y: bottomLeftP1.y - cornerRadii.bottomLeft * coefficient2
        )
        let bottomLeftP2CP1 = CGPoint(
            x: bottomLeftP2.x - cornerRadii.bottomLeft * coefficient3,
            y: bottomLeftP2.y - cornerRadii.bottomLeft * coefficient1
        )
        let bottomLeftP2CP2 = CGPoint(
            x: bottomLeftP2.x - cornerRadii.bottomLeft * coefficient5,
            y: bottomLeftP2.y - cornerRadii.bottomLeft * coefficient4
        )
        
        // MARK: Bottom Left Point 3 Points
        
        let bottomLeftP3 = CGPoint(
            x: bottomLeftP2.x - cornerRadii.bottomLeft * coefficient7,
            y: bottomLeftP2.y - cornerRadii.bottomLeft * coefficient7
        )
        let bottomLeftP3CP1 = CGPoint(
            x: bottomLeftP3.x - cornerRadii.bottomLeft * coefficient1,
            y: bottomLeftP3.y - cornerRadii.bottomLeft * coefficient3
        )
        let bottomLeftP3CP2 = CGPoint(
            x: bottomLeftP3.x - cornerRadii.bottomLeft * coefficient2,
            y: bottomLeftP3.y - cornerRadii.bottomLeft * coefficient6
        )
        
        // MARK: Bottom Left Point 4
        
        let bottomLeftP4 = CGPoint(
            x: bottomLeftP3.x - cornerRadii.bottomLeft * coefficient2,
            y: bottomLeftP3.y - cornerRadii.bottomLeft * coefficient10
        )
        
        // MARK: Top Left Point 1 Points
        
        let topLeftP1 = CGPoint(
            x: rect.origin.x,
            y: rect.origin.y + cornerRadii.topLeft * ellipseCoefficient
        )
        let topLeftP1CP1 = CGPoint(
            x: topLeftP1.x,
            y: topLeftP1.y - cornerRadii.topLeft * coefficient8
        )
        let topLeftP1CP2 = CGPoint(
            x: topLeftP1.x + cornerRadii.topLeft * coefficient0,
            y: topLeftP1.y - cornerRadii.topLeft * coefficient9
        )
        
        // MARK: Top Left Point 2 Points
        
        let topLeftP2 = CGPoint(
            x: topLeftP1.x + cornerRadii.topLeft * coefficient2,
            y: topLeftP1.y - cornerRadii.topLeft * coefficient10
        )
        let topLeftP2CP1 = CGPoint(
            x: topLeftP2.x + cornerRadii.topLeft * coefficient1,
            y: topLeftP2.y - cornerRadii.topLeft * coefficient3
        )
        let topLeftP2CP2 = CGPoint(
            x: topLeftP2.x + cornerRadii.topLeft * coefficient4,
            y: topLeftP2.y - cornerRadii.topLeft * coefficient5
        )
        
        // MARK: Top Left Point 3 Points
        
        let topLeftP3 = CGPoint(
            x: topLeftP2.x + cornerRadii.topLeft * coefficient7,
            y: topLeftP2.y - cornerRadii.topLeft * coefficient7
        )
        let topLeftP3CP1 = CGPoint(
            x: topLeftP3.x + cornerRadii.topLeft * coefficient3,
            y: topLeftP3.y - cornerRadii.topLeft * coefficient1
        )
        let topLeftP3CP2 = CGPoint(
            x: topLeftP3.x + cornerRadii.topLeft * coefficient6,
            y: topLeftP3.y - cornerRadii.topLeft * coefficient2
        )
        
        // MARK: Top Left Point 4
        
        let topLeftP4 = CGPoint(
            x: topLeftP3.x + cornerRadii.topLeft * coefficient10,
            y: topLeftP3.y - cornerRadii.topLeft * coefficient2
        )
        
        // MARK: Draw the Path
        
        path.move(to: CGPoint(x: rect.origin.x + cornerRadii.topLeft * ellipseCoefficient, y: rect.origin.y))
        
        path.addLine(to: topRightP1)
        path.addCurve(to: topRightP2, control1: topRightP1CP1, control2: topRightP1CP2)
        path.addCurve(to: topRightP3, control1: topRightP2CP1, control2: topRightP2CP2)
        path.addCurve(to: topRightP4, control1: topRightP3CP1, control2: topRightP3CP2)
        
        path.addLine(to: bottomRightP1)
        path.addCurve(to: bottomRightP2, control1: bottomRightP1CP1, control2: bottomRightP1CP2)
        path.addCurve(to: bottomRightP3, control1: bottomRightP2CP1, control2: bottomRightP2CP2)
        path.addCurve(to: bottomRightP4, control1: bottomRightP3CP1, control2: bottomRightP3CP2)
        
        path.addLine(to: bottomLeftP1)
        path.addCurve(to: bottomLeftP2, control1: bottomLeftP1CP1, control2: bottomLeftP1CP2)
        path.addCurve(to: bottomLeftP3, control1: bottomLeftP2CP1, control2: bottomLeftP2CP2)
        path.addCurve(to: bottomLeftP4, control1: bottomLeftP3CP1, control2: bottomLeftP3CP2)
        
        path.addLine(to: topLeftP1)
        path.addCurve(to: topLeftP2, control1: topLeftP1CP1, control2: topLeftP1CP2)
        path.addCurve(to: topLeftP3, control1: topLeftP2CP1, control2: topLeftP2CP2)
        path.addCurve(to: topLeftP4, control1: topLeftP3CP1, control2: topLeftP3CP2)
        
        path.closeSubpath()
        
        return path
    }
    
    // MARK: Private Static Interface
    
    private static func minimumCornerRadii(
        for rect: CGRect,
        with cornerRadii: CornerRadii
    ) -> CornerRadii {
        let minimumTopRight = singleMinimumCornerRadius(
            width: rect.width,
            height: rect.height,
            targetRadius: cornerRadii.topRight
        )
        
        let minimumBottomRight = singleMinimumCornerRadius(
            width: rect.width,
            height: rect.height - (minimumTopRight * ellipseCoefficient),
            targetRadius: cornerRadii.bottomRight
        )
        
        let minimumBottomLeft = singleMinimumCornerRadius(
            width: rect.width - (minimumBottomRight * ellipseCoefficient),
            height: rect.height,
            targetRadius: cornerRadii.bottomLeft
        )
        
        let minimumTopLeft = singleMinimumCornerRadius(
            width: rect.width,
            height: rect.height,
            targetRadius: cornerRadii.topRight
        )
        
        return CornerRadii(
            topLeft: minimumTopLeft,
            topRight: minimumTopRight,
            bottomLeft: minimumBottomLeft,
            bottomRight: minimumBottomRight
        )
    }
    
    private static func singleMinimumCornerRadius(width: CGFloat, height: CGFloat, targetRadius: CGFloat) -> CGFloat {
        let minSide = min(width, height)
        let minRadius = min(targetRadius * ellipseCoefficient, minSide)
        
        return minRadius / ellipseCoefficient
    }
}
