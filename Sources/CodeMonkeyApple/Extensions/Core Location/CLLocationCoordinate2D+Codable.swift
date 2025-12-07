//
//  CLLocationCoordinate2D+Codable
//  CodeMonkeyApple
//
//  Created by Kyle Hughes on 6/10/23.
//

import CoreLocation

// MARK: - CLLocationCoordinate2D.CodingKeys Definition

extension CLLocationCoordinate2D {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

// MARK: - Decodable Extension

extension CLLocationCoordinate2D: @retroactive Decodable {
    // MARK: Public Initialization
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        self.init(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Encodable Extension

extension CLLocationCoordinate2D: @retroactive Encodable {
    // MARK: Public Instance Interface
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}
