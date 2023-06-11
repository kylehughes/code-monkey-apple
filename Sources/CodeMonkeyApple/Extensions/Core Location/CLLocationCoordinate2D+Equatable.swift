//
//  CLLocationCoordinate2D+Equatable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CoreLocation

// MARK: - Equatable Extension

extension CLLocationCoordinate2D: Equatable {
    // MARK: Public Static Interface
    
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
