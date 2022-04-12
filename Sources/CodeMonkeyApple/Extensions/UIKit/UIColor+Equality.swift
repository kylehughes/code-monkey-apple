//
//  UIColor+Equality.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/11/22.
//

#if canImport(UIKit)
import UIKit

extension UIColor {
    // MARK: Public Instance Interface
    
    public func rgbaEqualsRGBA(from rhs: UIColor) -> Bool {
        var lhsR: CGFloat = 0
        var lhsG: CGFloat = 0
        var lhsB: CGFloat = 0
        var lhsA: CGFloat = 0
        getRed(&lhsR, green: &lhsG, blue: &lhsB, alpha: &lhsA)

        var rhsR: CGFloat = 0
        var rhsG: CGFloat = 0
        var rhsB: CGFloat = 0
        var rhsA: CGFloat = 0
        rhs.getRed(&rhsR, green: &rhsG, blue: &rhsB, alpha: &rhsA)

        return
            lhsR == rhsR &&
            lhsG == rhsG &&
            lhsB == rhsB &&
            lhsA == rhsA
    }
}
#endif
