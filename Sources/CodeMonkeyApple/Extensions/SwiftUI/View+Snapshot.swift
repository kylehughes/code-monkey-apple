//
//  View+Snapshot.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/18/21.
//

import SwiftUI
import UIKit

extension View {
    // MARK: Public Instance Interface
    
    public func snapshot() -> UIImage {
        UIView.setAnimationsEnabled(false)
        
        defer {
            UIView.setAnimationsEnabled(true)
        }
        
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
