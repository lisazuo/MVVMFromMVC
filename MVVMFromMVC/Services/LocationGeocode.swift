//
//  LocationGeocode.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//

import Foundation

//turns a string into a Location.
class LocationGeocoder {
    init() {
        
    }
    
    func getcode(adressString: String, completion: ([Location]) -> Void ) {
        let fileURL = Bundle.main.path(forResource: "weatherData.geojson", ofType: nil)
        do {
            let url = URL(fileURLWithPath: fileURL!)
            let data = try! Data.init(contentsOf: url)
            let locationList = try JSONDecoder().decode([Location].self, from: data)
            let location = locationList.filter({ $0.locationName == adressString })
            completion(location)
        }
        catch {
           print(error)
        }
        
    }
}
