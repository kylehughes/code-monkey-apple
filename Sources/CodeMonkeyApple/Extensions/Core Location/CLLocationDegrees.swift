//
//  CLLocationDegrees.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/3/23.
//

import CoreLocation

extension CLLocationDegrees {
    // MARK: Public Initialization
    
    public init?(dms: String) {
        let components = dms.components(separatedBy: ["°", "′", "″"])
        
        guard
            components.count == 4,
            let degrees = Double(components[0]),
            let minutes = Double(components[1]),
            let seconds = Double(components[2])
        else {
                return nil
        }
        
        let direction: Double = (components[3] == "S" || components[3] == "W") ? -1.0 : 1.0
        
        self = direction * (degrees + (minutes / 60.0) + (seconds / 3600.0))
    }
}
