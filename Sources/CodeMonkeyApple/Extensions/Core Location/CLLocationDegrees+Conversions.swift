//
//  CLLocationDegrees+Conversions.swift
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
    /// - The degrees value (DD.DDDD) is a decimal number, and the direction is indicated by one of the cardinal
    ///   direction symbols (N, S, E, W) after the degree symbol.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format, if the degrees value
    ///   cannot be converted to a Double, or if the direction symbol is not one of the cardinal direction symbols.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(decimalDegrees: "12.345°N") // 12.345
    /// let longitude = CLLocationDegrees(decimalDegrees: "98.765°W") // -98.765
    /// ```
    ///
    /// - Parameter decimalDegrees: The latitude or longitude as a string in Decimal Degrees (DD) format.
    /// - Returns: A new value if the input string could be successfully converted, or `nil` otherwise.
    @inlinable
    public init?(decimalDegrees: String) {
        let components = decimalDegrees.components(separatedBy: ["°"])
                
        guard
            components.count == 2,
            let degrees = Double(components[0]),
            let direction = CardinalDirection(rawValue: components[1])
        else {
            return nil
        }
        
        self = direction.multiplier * degrees
    }
    
    /// Creates a new value from a string in Degrees Decimal Minutes (DDM) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM.MMM'[N/S/E/W]". For example, "12°34.567'N".
    /// - The degrees value (DD) and minutes value (MM.MMM) are decimal numbers, and the direction is indicated by one
    ///   of the cardinal direction symbols (N, S, E, W) after the minute symbol.
    /// - The minutes value must be less than 60.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format, if the degrees or minutes
    ///   values cannot be converted to a Double, or if the direction symbol is not one of the cardinal direction
    ///  symbols.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(degreesDecimalMinutes: "12°34.567'N") // 12.57611...
    /// let longitude = CLLocationDegrees(degreesDecimalMinutes: "98°45.543'W") // -98.75905...
    /// ```
    ///
    /// - Parameter degreesDecimalMinutes: The latitude or longitude as a string in Degrees Decimal Minutes (DDM)
    ///   format.
    /// - Returns: A new value if the input string could be successfully converted, or `nil` otherwise.
    @inlinable
    public init?(degreesDecimalMinutes: String) {
        let components = degreesDecimalMinutes.components(separatedBy: ["°", "'", "′"])
        
        guard
            components.count == 3,
            let degrees = Double(components[0]),
            let decimalMinutes = Double(components[1]),
            decimalMinutes < 60,
            let direction = CardinalDirection(rawValue: components[2])
        else {
            return nil
        }
        
        self = direction.multiplier * (degrees + (decimalMinutes / 60))
    }
    
    /// Creates a new value from a string in Degrees, Minutes, Seconds (DMS) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM′SS″[N/S/E/W]". For example, "12°34′56″N".
    /// - The degrees value (DD), minutes value (MM), and seconds value (SS) are decimal numbers, and the direction is
    ///   indicated by one of the cardinal direction symbols (N, S, E, W) after the second symbol.
    /// - The minutes and seconds values must be less than 60.
    /// - The direction is either "N" or "E" for positive values, and "S" or "W" for negative values.
    /// - The function will return `nil` if the input string is not in the correct format, if the degrees, minutes, or
    ///   seconds values cannot be converted to a Double, or if the direction symbol is not one of the cardinal
    ///   direction symbols.
    ///
    /// **Examples**
    ///
    /// ```
    /// let latitude = CLLocationDegrees(degreesMinutesSeconds: "12°34′56″N") // 12.58222...
    /// let longitude = CLLocationDegrees(degreesMinutesSeconds: "98°45′54″W") // -98.765...
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
            minutes < 60,
            let seconds = Double(components[2]),
            seconds < 60,
            let direction = CardinalDirection(rawValue: components[3])
        else {
            return nil
        }
        
        self = direction.multiplier * (degrees + (minutes / 60) + (seconds / 3600))
    }
    
    // MARK: Public Instance Interface
    
    /// Check if the degree is within the valid range for latitude (-90 to 90).
    public var isInBoundsForLatitude: Bool {
        -90 <= self && self <= 90
    }
    
    /// Check if the degree is within the valid range for longitude (-180 to 180).
    public var isInBoundsForLongitude: Bool {
        -180 <= self && self <= 180
    }
}

// MARK: - CLLocationDegrees.CardinalDirection Definition

extension CLLocationDegrees {
    /// An enumeration representing cardinal directions used for geographical coordinates.
    public enum CardinalDirection: String, CaseIterable {
        /// North direction, typically representing a positive latitude.
        case north = "N"
        
        /// South direction, typically representing a negative latitude.
        case south = "S"
        
        /// East direction, typically representing a positive longitude.
        case east = "E"
        
        /// West direction, typically representing a negative longitude.
        case west = "W"
        
        /// A multiplier associated with each cardinal direction.
        ///
        /// It's typically used for adjusting the sign of geographical coordinates.
        ///
        /// North and East return `1`, while South and West return `-1`.
        public var multiplier: Double {
            switch self {
            case .south, .west:
                return -1
            case .north, .east:
                return 1
            }
        }
    }
}
