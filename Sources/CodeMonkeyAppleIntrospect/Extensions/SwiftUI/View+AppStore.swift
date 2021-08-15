//
//  View+AppStore.swift
//  CodeMonkeyAppleIntrospect
//
//  Created by Kyle Hughes on 7/19/21.
//

import StoreKit
import SwiftUI

extension View {
    // MARK: Present App Product Pages

    public func appStoreProductPage(
        for appID: String,
        when shouldPresent: Binding<Bool>,
        tintColor: Color = .accentColor
    ) -> some View {
        viewController(when: shouldPresent) {
            let productViewController = SKStoreProductViewController()
            
            productViewController.loadProduct(
                withParameters: [
                    SKStoreProductParameterITunesItemIdentifier: appID
                ]
            )
            productViewController.view.tintColor = UIColor(tintColor)
            
            return productViewController
        }
    }
    
    public func appStoreProductPage(
        for appID: Binding<String?>,
        tintColor: Color = .accentColor
    ) -> some View {
        viewController(with: appID) { appID in
            let productViewController = SKStoreProductViewController()
            
            productViewController.loadProduct(
                withParameters: [
                    SKStoreProductParameterITunesItemIdentifier: appID
                ]
            )
            productViewController.view.tintColor = UIColor(tintColor)
            
            return productViewController
        }
    }
}
