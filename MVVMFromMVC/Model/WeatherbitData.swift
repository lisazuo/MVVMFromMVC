//
//  WeatherData.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//

import Foundation

//class that represents the data returned by the Weatherbit API
class WeatherbitData: Codable {
    let iconName: String
    //    let date: NSDate
    let date: String
    let currentTemp: Double
    let description: String
    let latitude: Double
    let longitude: Double
    
    enum Codingkeys: String, CodingKey {
        case iconName, date, currentTemp, description, latitude, longitude
    }
    // initilizer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        iconName = try container.decode(String.self, forKey: .iconName)
        date = try container.decode(String.self, forKey: .date)
        currentTemp = try container.decode(Double.self, forKey: .currentTemp)
        description = try container.decode(String.self, forKey: .description)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
