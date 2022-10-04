//
//  View+AppStore.swift
//  Music Triage
//
//  Created by Kyle Hughes on 10/2/22.
//

#if canImport(UIKit)

import StoreKit
import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    public func appStoreProductPage(
        for appID: String,
        when shouldPresent: Binding<Bool>,
        tintColor: Color = .accentColor
    ) -> some View {
        viewControllerSpringboard(isPresented: shouldPresent) {
            Coordinator {
                shouldPresent.wrappedValue = false
            }
        } action: { viewController, coordinator, _ in
            let productViewController = SKStoreProductViewController()
            productViewController.delegate = coordinator
            
            productViewController.loadProduct(
                withParameters: [
                    SKStoreProductParameterITunesItemIdentifier: appID
                ]
            )
            productViewController.view.tintColor = UIColor(tintColor)
            
            viewController.present(productViewController, animated: true)
        }
    }
    
    public func appStoreProductPage(
        for appID: Binding<String?>,
        tintColor: Color = .accentColor
    ) -> some View {
        viewControllerSpringboard(with: appID) {
            Coordinator {
                appID.wrappedValue = nil
            }
        } action: { viewController, coordinator, appID in
            let productViewController = SKStoreProductViewController()
            productViewController.delegate = coordinator
            
            productViewController.loadProduct(
                withParameters: [
                    SKStoreProductParameterITunesItemIdentifier: appID
                ]
            )
            productViewController.view.tintColor = UIColor(tintColor)
            
            viewController.present(productViewController, animated: true)
        }
    }
}

// MARK: - Coordinator Definition

private final class Coordinator: NSObject {
    private let onDismiss: () -> Void
    
    // MARK: Fileprivate Inialization
    
    fileprivate init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
}

// MARK: - SKStoreProductViewControllerDelegate Extension

extension Coordinator: SKStoreProductViewControllerDelegate {
    // MARK: Responding to a Dismiss Action
    
    fileprivate func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        onDismiss()
    }
}

#endif
