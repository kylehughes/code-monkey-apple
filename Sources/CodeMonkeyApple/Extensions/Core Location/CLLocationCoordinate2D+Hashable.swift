//
//  CLLocationCoordinate2D+Hashable.swift
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CoreLocation

// MARK: - Hashable Extension

extension CLLocationCoordinate2D: Hashable {
    // MARK: Public Static Interface
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
