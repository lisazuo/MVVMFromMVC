//
//  Location.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//

import Foundation

//class for location data Apple’s CLLocation service returns.
class Location: Codable {
    let locationName: String?
    let latitude: Double
    let longitude: Double
    
    enum Codingkeys: String, CodingKey {
        case locationName, latitude, longitude
    }
    
    // initilizer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        locationName = try container.decode(String.self, forKey: .locationName)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }

    
}
