//
//  CLLocationCoordinate2D+Conversions
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CoreLocation

extension CLLocationCoordinate2D {
    // MARK: Public Initialization
    
    /// Creates a new `CLLocationCoordinate2D` from a single string containing both latitude and longitude in
    /// Decimal Degrees (DD) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD.DDDD°[N/S/E/W] DD.DDDD°[N/S/E/W]".
    /// - Latitude and longitude values must be separated by a space.
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If the string cannot be parsed in the DD format, or if either the latitude or longitude is out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(decimalDegrees: "12.345°N 98.765°W")
    /// ```
    ///
    /// - Parameter coordinate: The latitude and longitude as a single string in DD format.
    /// - Returns: A new `CLLocationCoordinate2D` if the input string could be successfully converted and both the
    ///   latitude and longitude are within the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(decimalDegrees coordinate: String) {
        let components = coordinate.components(separatedBy: " ")
        
        guard components.count == 2 else {
            return nil
        }
        
        self.init(decimalDegreesLatitude: components[0], longitude: components[1])
    }
    
    /// Creates a new `CLLocationCoordinate2D` from two separate strings for latitude and longitude, each in
    /// Decimal Degrees (DD) format.
    ///
    /// **Requirements**
    ///
    /// - Each input string must be in the format "DD.DDDD°[N/S/E/W]". For example, "12.345°N".
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If either string cannot be parsed in the DD format, or if either the latitude or longitude is out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(
    ///     decimalDegreesLatitude: "12.345°N",
    ///     longitude: "98.765°W"
    /// )
    /// ```
    ///
    /// - Parameter latitude: The latitude as a string in DD format.
    /// - Parameter longitude: The longitude as a string in DD format.
    /// - Returns: A new `CLLocationCoordinate2D` if both input strings could be successfully converted and are within
    ///   the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(decimalDegreesLatitude latitudeString: String, longitude longitudeString: String) {
        guard
            let latitude = CLLocationDegrees(decimalDegrees: latitudeString),
            latitude.isInBoundsForLatitude,
            let longitude = CLLocationDegrees(decimalDegrees: longitudeString),
            longitude.isInBoundsForLongitude
        else {
            return nil
        }

        self.init(latitude: latitude, longitude: longitude)
    }

    /// Creates a new `CLLocationCoordinate2D` from a single string containing both latitude and longitude in
    /// Degrees Decimal Minutes (DDM) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM.MMMM′ [N/S/E/W] DD°MM.MMMM′ [N/S/E/W]".
    /// - Latitude and longitude values must be separated by a space.
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If the string cannot be parsed in the DDM format, or if either the latitude or longitude is out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: "12°34.567′N 98°76.543′W")
    /// ```
    ///
    /// - Parameter coordinate: The latitude and longitude as a single string in DDM format.
    /// - Returns: A new `CLLocationCoordinate2D` if the input string could be successfully converted and both the
    ///   latitude and longitude are within the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(degreesDecimalMinutes coordinate: String) {
        let components = coordinate.components(separatedBy: " ")
        
        guard components.count == 2 else {
            return nil
        }
        
        self.init(degreesDecimalMinutesLatitude: components[0], longitude: components[1])
    }
    
    /// Creates a new `CLLocationCoordinate2D` from two separate strings for latitude and longitude, each in
    /// Degrees Decimal Minutes (DDM) format.
    ///
    /// **Requirements**
    ///
    /// - Each input string must be in the format "DD°MM.MMMM′ [N/S/E/W]".
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If either string cannot be parsed in the DDM format, or if either the latitude or longitude is out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(
    ///     degreesDecimalMinutesLatitude: "12°34.567′N",
    ///     longitude: "98°76.543′W"
    /// )
    /// ```
    ///
    /// - Parameter latitude: The latitude as a string in DDM format.
    /// - Parameter longitude: The longitude as a string in DDM format.
    /// - Returns: A new `CLLocationCoordinate2D` if both input strings could be successfully converted and both the
    ///   latitude and longitude are within the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(degreesDecimalMinutesLatitude latitudeString: String, longitude longitudeString: String) {
        guard
            let latitude = CLLocationDegrees(degreesDecimalMinutes: latitudeString),
            latitude.isInBoundsForLatitude,
            let longitude = CLLocationDegrees(degreesDecimalMinutes: longitudeString),
            longitude.isInBoundsForLongitude
        else {
            return nil
        }
        
        self.init(latitude: latitude, longitude: longitude)
    }

    /// Creates a new `CLLocationCoordinate2D` from a single string containing both latitude and longitude, each in
    /// Degrees Minutes Seconds (DMS) format.
    ///
    /// **Requirements**
    ///
    /// - The input string must be in the format "DD°MM′SS″ [N/S/E/W] DD°MM′SS″ [N/S/E/W]".
    /// - The first coordinate in the string is interpreted as the latitude, and the second coordinate as the longitude.
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If the string cannot be parsed in the DMS format, doesn't contain exactly two coordinates, or either the
    ///   latitude or longitude is out of bounds, the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: "12°20′42″N 98°45′54″W")
    /// ```
    ///
    /// - Parameter coordinate: The latitude and longitude as a single string in DMS format.
    /// - Returns: A new `CLLocationCoordinate2D` if the input string could be successfully converted, both coordinates
    ///   are present, and both the latitude and longitude are within the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(degreesMinutesSeconds coordinate: String) {
        let components = coordinate.components(separatedBy: " ")
        
        guard components.count == 2 else {
            return nil
        }
        
        self.init(degreesMinutesSecondsLatitude: components[0], longitude: components[1])
    }

    /// Creates a new `CLLocationCoordinate2D` from two separate strings for latitude and longitude, each in
    /// Degrees Minutes Seconds (DMS) format.
    ///
    /// **Requirements**
    ///
    /// - Each input string must be in the format "DD°MM′SS″ [N/S/E/W]".
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - If either string cannot be parsed in the DMS format, or if either the latitude or longitude is out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate = CLLocationCoordinate2D(degreesMinutesSecondsLatitude: "12°20′42″N", longitude: "98°45′54″W")
    /// ```
    ///
    /// - Parameter latitude: The latitude as a string in DMS format.
    /// - Parameter longitude: The longitude as a string in DMS format.
    /// - Returns: A new `CLLocationCoordinate2D` if both input strings could be successfully converted and both the
    ///   latitude and longitude are within the valid ranges, or `nil` otherwise.
    @inlinable
    public init?(degreesMinutesSecondsLatitude latitudeString: String, longitude longitudeString: String) {
        guard
            let latitude = CLLocationDegrees(degreesMinutesSeconds: latitudeString),
            latitude.isInBoundsForLatitude,
            let longitude = CLLocationDegrees(degreesMinutesSeconds: longitudeString),
            longitude.isInBoundsForLongitude
        else {
            return nil
        }
        
        self.init(latitude: latitude, longitude: longitude)
    }
    
    /// Creates a new `CLLocationCoordinate2D` from a string, attempting to parse it in the order of popularity of
    /// coordinate formats: Decimal Degrees (DD), Degrees Decimal Minutes (DDM), Degrees Minutes Seconds (DMS).
    ///
    /// **Requirements**
    ///
    /// - The input string must be either in the format "DD.DDDD°[N/S/E/W] DD.DDDD°[N/S/E/W]",
    ///   "DD°MM.MMM' [N/S/E/W] DD°MM.MMM' [N/S/E/W]", or "DD°MM′SS″ [N/S/E/W] DD°MM′SS″ [N/S/E/W]".
    /// - In each format, the first part is the latitude and the second part is the longitude.
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - The function will attempt to parse the string first as Decimal Degrees (DD), then as Degrees Decimal Minutes
    ///   (DDM), and finally as Degrees Minutes Seconds (DMS). It will return as soon as it successfully parses the
    ///   string and the latitude and longitude are within their respective valid ranges.
    /// - If the string cannot be parsed in any of these formats or the latitude or longitude is out of bounds, the function
    ///   will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate1 = CLLocationCoordinate2D(coordinate: "12.345°N 98.765°W") // Parses as DD
    /// let coordinate2 = CLLocationCoordinate2D(coordinate: "12°20.7′N 98°45.9′W") // Parses as DDM
    /// let coordinate3 = CLLocationCoordinate2D(coordinate: "12°20′42″N 98°45′54″W") // Parses as DMS
    /// ```
    ///
    /// - Parameter coordinateString: The latitude and longitude as a string in one of the accepted formats.
    /// - Returns: A new `CLLocationCoordinate2D` if the input string could be successfully converted and both the
    ///   latitude and longitude are within their valid ranges, or `nil` otherwise.
    @inlinable
    public init?(coordinate coordinateString: String) {
        if let coordinate = CLLocationCoordinate2D(decimalDegrees: coordinateString) {
            self = coordinate
        } else if let coordinate = CLLocationCoordinate2D(degreesDecimalMinutes: coordinateString) {
            self = coordinate
        } else if let coordinate = CLLocationCoordinate2D(degreesMinutesSeconds: coordinateString) {
            self = coordinate
        } else {
            return nil
        }
    }

    /// Creates a new `CLLocationCoordinate2D` from two separate strings for latitude and longitude, attempting
    /// to parse each in the order of popularity of coordinate formats: Decimal Degrees (DD), Degrees Decimal Minutes
    /// (DDM), Degrees Minutes Seconds (DMS).
    ///
    /// **Requirements**
    ///
    /// - Each input string must be either in the format "DD.DDDD°[N/S/E/W]", "DD°MM.MMM' [N/S/E/W]", or
    ///   "DD°MM′SS″[N/S/E/W]".
    /// - The latitude must be between -90 and +90 degrees, and the longitude must be between -180 and +180 degrees.
    /// - The function will attempt to parse each string first as Decimal Degrees (DD), then as Degrees Decimal Minutes
    ///   (DDM),
    ///   and finally as Degrees Minutes Seconds (DMS). It will return as soon as both strings are successfully parsed.
    /// - If either string cannot be parsed in any of these formats or the latitude or longitude are out of bounds,
    ///   the function will return `nil`.
    ///
    /// **Examples**
    ///
    /// ```swift
    /// let coordinate1 = CLLocationCoordinate2D(latitude: "12.345°N", longitude: "98.765°W")
    /// let coordinate2 = CLLocationCoordinate2D(latitude: "12°20.7′N", longitude: "98°45.9′W")
    /// let coordinate3 = CLLocationCoordinate2D(latitude: "12°20′42″N", longitude: "98°45′54″W")
    /// ```
    ///
    /// - Parameter latitudeString: The latitude as a string in one of the accepted formats.
    /// - Parameter longitudeString: The longitude as a string in one of the accepted formats.
    /// - Returns: A new `CLLocationCoordinate2D` if both input strings could be successfully converted and both the
    ///   latitude and longitude are within their valid ranges, or `nil` otherwise.
    @inlinable
    public init?(latitude latitudeString: String, longitude longitudeString: String) {
        if
            let coordinate = CLLocationCoordinate2D(
                decimalDegreesLatitude: latitudeString,
                longitude: longitudeString
            )
        {
            self = coordinate
        } else if
            let coordinate = CLLocationCoordinate2D(
                degreesDecimalMinutesLatitude: latitudeString,
                longitude: longitudeString
            )
        {
            self = coordinate
        } else if
            let coordinate = CLLocationCoordinate2D(
                degreesMinutesSecondsLatitude: latitudeString,
                longitude: longitudeString
            )
        {
            self = coordinate
        } else {
            return nil
        }
    }
}
