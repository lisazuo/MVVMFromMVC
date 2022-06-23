//
//  WeatherbitService.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//

import Foundation

//fetches the weather data from the Weatherbit api
class WeatherbitService {
    static func weatherDataForLocation(
        latitude: Double,
        longitude: Double, completion: ((WeatherbitData?, Error?) -> Void)) {
            let fileURL = Bundle.main.path(forResource: "WeatherbitData.geojson", ofType: nil)
            do {
                let url = URL(fileURLWithPath: fileURL!)
                let data = try! Data.init(contentsOf: url)
                let weatherbitDataList = try JSONDecoder().decode([WeatherbitData].self, from: data)
                let weatherbitData = weatherbitDataList.filter({ $0.latitude == latitude }).first
                completion(weatherbitData,nil)
            }
            catch {
            }
        }
}
