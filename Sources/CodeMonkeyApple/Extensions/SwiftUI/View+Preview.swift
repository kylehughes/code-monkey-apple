//
//  View+Preview.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/12/21.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    public func defaultPreviewDevice() -> some View {
        previewDevice("iPhone 12 mini")
    }
}
