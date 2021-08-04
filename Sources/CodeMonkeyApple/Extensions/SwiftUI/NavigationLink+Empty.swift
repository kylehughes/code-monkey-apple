//
//  NavigationLink+Empty.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/12/21.
//

import SwiftUI

extension NavigationLink {
    // MARK: Public Initialization
    
    public init(destination: Destination, isActive: Binding<Bool>) where Label == EmptyView {
        self.init(destination: destination, isActive: isActive) {
            EmptyView()
        }
    }
}
