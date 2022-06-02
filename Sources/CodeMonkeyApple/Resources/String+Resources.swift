//
//  String+Resources.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/3/22.
//

import Foundation

// MARK: - Common Strings

extension String {
    public static let `default` = NSLocalizedString(
        "DEFAULT",
        value: "Default",
        comment: "Label for a value that is the default selection."
    )
}

// MARK: - Specific Strings

extension String {
    // MARK: Runtime Accent Color
    
    public static let blackWhiteColor = NSLocalizedString(
        "COLOR_BLACK_WHITE",
        value: "Black & White",
        comment: "Label for a color that can be either black or white."
    )
    
    public static let blueColor = NSLocalizedString(
        "COLOR_BLUE",
        value: "Blue",
        comment: "Name of the color blue."
    )
    
    public static let brownColor = NSLocalizedString(
        "COLOR_BROWN",
        value: "Brown",
        comment: "Name of the color brown."
    )
    
    public static let coralColor = NSLocalizedString(
        "COLOR_CORAL",
        value: "Coral",
        comment: "Name of the color coral."
    )
    
    public static let cyanColor = NSLocalizedString(
        "COLOR_CYAN",
        value: "Cyan",
        comment: "Name of the color cyan."
    )
    
    public static let greenColor = NSLocalizedString(
        "COLOR_GREEN",
        value: "Green",
        comment: "Name of the color green."
    )
    
    public static let indigoColor = NSLocalizedString(
        "COLOR_INDIGO",
        value: "Indigo",
        comment: "Name of the color indigo."
    )
    
    public static let mintColor = NSLocalizedString(
        "COLOR_MINT",
        value: "Mint",
        comment: "Name of the color mint."
    )
    
    public static let orangeColor = NSLocalizedString(
        "COLOR_ORANGE",
        value: "Orange",
        comment: "Name of the color orange."
    )
    
    public static let pinkColor = NSLocalizedString(
        "COLOR_PINK",
        value: "Pink",
        comment: "Name of the color pink."
    )
    
    public static let purpleColor = NSLocalizedString(
        "COLOR_PURPLE",
        value: "Purple",
        comment: "Name of the color purple."
    )
    
    public static let redColor = NSLocalizedString(
        "COLOR_RED",
        value: "Red",
        comment: "Name of the color red."
    )
    
    public static let tealColor = NSLocalizedString(
        "COLOR_TEAL",
        value: "Teal",
        comment: "Name of the color teal."
    )
    
    public static let yellowColor = NSLocalizedString(
        "COLOR_YELLOW",
        value: "Yellow",
        comment: "Name of the color yellow."
    )
    
    // MARK: Runtime Color Scheme
    
    public static let darkColorScheme = NSLocalizedString(
        "COLOR_SCHEME_DARK",
        value: "Dark",
        comment: "Title for a dark color scheme; most colors are dark with a black background."
    )
    
    public static let lightColorScheme = NSLocalizedString(
        "COLOR_SCHEME_LIGHT",
        value: "Light",
        comment: "Title for a dark color scheme; most colors are light with a white background."
    )
    
    public static let systemColorScheme = NSLocalizedString(
        "COLOR_SCHEME_SYSTEM",
        value: "System",
        comment: "Title for the color scheme that is set at the operating-system level and applies to all apps."
    )
}
