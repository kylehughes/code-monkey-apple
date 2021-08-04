//
//  View+SpecificModifiers.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 7/12/21.
//

import SwiftUI

extension View {
    // MARK: Public Instance Interface
    
    /// Value comes from "What's new in SwiftUI" from WWDC 2021.
    public func maxWidthForBorderedButton() -> some View {
        frame(maxWidth: 300)
    }
    
    /// Value comes from testing a TextEditor with one character.
    func minimumHeightForTextEditorInForm() -> some View {
        frame(minHeight: 38)
    }
    
    public func paddingForMultilineTextContentInInsetGroupedList() -> some View {
        padding(.vertical, 8)
    }
    
    func sectionHeaderAndFooterHidden() -> some View {
        labelsHidden()
    }
}
