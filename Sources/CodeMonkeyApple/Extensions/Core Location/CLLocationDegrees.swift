//
//  CLLocationDegrees.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/3/23.
//

import CoreLocation

extension CLLocationDegrees {
    // MARK: Public Initialization
    
    /// Creates a new value from a string in Decimal Degrees (DD) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD.DDDD°[N/S/E/W]". For example, "12.345°N".
    /// - The degrees value (DD.DDDD) is a decimal number, and the direction is indicated by the letter after the
    ///   degree symbol.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format or if the degrees value
    ///   cannot be converted to a Double.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(decimalDegrees: "12.345°N") // Returns 12.345
    /// let longitude = CLLocationDegrees(decimalDegrees: "98.765°W") // Returns -98.765
    /// ```
    ///
    /// - Parameter decimalDegrees: The latitude or longitude as a string in Decimal Degrees (DD) format.
    /// - Returns: A new value if the input string could be successfully converted, or `nil` otherwise.
    @inlinable
    public init?(decimalDegrees: String) {
        let components = decimalDegrees.components(separatedBy: ["°"])
        
        guard
            components.count == 2,
            let degrees = Double(components[0])
        else {
            return nil
        }
        
        let direction: Double = (components[1] == "S" || components[1] == "W") ? -1 : 1
        
        self = direction * degrees
    }
    
    /// Creates a new value from a string in Degrees Decimal Minutes (DDM) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM.MMM'[N/S/E/W]". For example, "12°34.567'N".
    /// - The degrees value (DD) and minutes value (MM.MMM) are decimal numbers, and the direction is indicated by
    ///   the letter after the minute symbol.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format or if the degrees or minutes
    ///   values cannot be converted to a Double.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(degreesDecimalMinutes: "12°34.567'N") // Returns 12.57611...
    /// let longitude = CLLocationDegrees(degreesDecimalMinutes: "98°76.543'W") // Returns -98.77572...
    /// ```
    ///
    /// - Parameter degreesDecimalMinutes: The latitude or longitude as a string in Degrees Decimal Minutes (DDM)
    ///   format.
    /// - Returns: A new value if the input string could be successfully converted, or `nil` otherwise.
    @inlinable
    public init?(degreesDecimalMinutes: String) {
        let components = degreesDecimalMinutes.components(separatedBy: ["°", "'"])
        
        guard
            components.count == 3,
            let degrees = Double(components[0]),
            let decimalMinutes = Double(components[1])
        else {
            return nil
        }
        
        let direction: Double = (components[2] == "S" || components[2] == "W") ? -1 : 1
        
        self = direction * (degrees + (decimalMinutes / 60))
    }
    
    /// Creates a new value from a string in Degrees, Minutes, Seconds (DMS) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM′SS″[N/S/E/W]". For example, "12°34′56″N".
    /// - The degrees value (DD), minutes value (MM), and seconds value (SS) are decimal numbers, and the direction is
    ///   indicated by the letter after the second symbol.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format or if the degrees, minutes, or
    ///   seconds values cannot be converted to a Double.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(degreesMinutesSeconds: "12°34′56″N") // Returns 12.58222...
    /// let longitude = CLLocationDegrees(degreesMinutesSeconds: "98°76′54″W") // Returns -98.78167...
    /// ```
    ///
    /// - Parameter degreesMinutesSeconds: The latitude or longitude as a string in Degrees, Minutes, Seconds (DMS)
    ///   format.
    /// - Returns: A new value if the input string could be successfully converted, or `nil` otherwise.
    @inlinable
    public init?(degreesMinutesSeconds: String) {
        let components = degreesMinutesSeconds.components(separatedBy: ["°", "′", "″"])
        
        guard
            components.count == 4,
            let degrees = Double(components[0]),
            let minutes = Double(components[1]),
            let seconds = Double(components[2])
        else {
            return nil
        }
        
        let direction: Double = (components[3] == "S" || components[3] == "W") ? -1 : 1
        
        self = direction * (degrees + (minutes / 60) + (seconds / 3600))
    }
}
