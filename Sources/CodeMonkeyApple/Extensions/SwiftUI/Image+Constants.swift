//
//  Image+Constants.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 4/18/22.
//

import SwiftUI

extension Image {
    // MARK: Public Static Interface
    
    public static var boldCheckmark: some View {
        Image(systemName: "checkmark")
            .font(.body.bold())
    }
}
