//
//  WeatherViewModel.swift
//  MTest
//
//  Created by lisa on 20/06/22.
//viewModel is responsible for formatting data from service and model types to present in the views.

import Foundation
// 1
import UIKit.UIImage
// 2
public class WeatherViewModel {
    
    // 1
    private let geocoder = LocationGeocoder()
    // 2
    private let defaultAddress = "Beijing"
    
    // 3
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter
    }()
    
    // 4
    private let tempFormatter: NumberFormatter = {
        let tempFormatter = NumberFormatter()
        tempFormatter.numberStyle = .none
        return tempFormatter
    }()
    
    // define observable object
    var locationName = Box("Loading...")
    let date = Box(" ")
    let icon: Box<UIImage?> = Box(nil)  //no image initially
    let summary = Box(" ")
    let forecastSummary = Box(" ")
    
    init() {
        changeLocation(to: self.defaultAddress)
    }
    
    func changeLocation(to newLocation: String) {
        locationName.value = "Loading..."
        
        geocoder.getcode(adressString: newLocation) { [weak self] locations in
            guard let self = self else {
                return
            }
            if let location = locations.first {
                self.locationName.value = location.locationName ?? "Not found location name"
                self.fetchWeatherForLocation(location)
            } else  {
                self.locationName.value = "Not found"
                self.date.value = ""
                self.icon.value = nil
                self.summary.value = ""
                self.forecastSummary.value = ""
            }
        }
    }

    
    private func fetchWeatherForLocation(_ location: Location) {
        
        WeatherbitService.weatherDataForLocation(latitude: location.latitude,
                                                 longitude: location.longitude) { [weak self] (weatherData, error) in
            guard let self = self,
                  let weatherData = weatherData else {
                return
            }
//            self.date.value = self.dateFormatter.string(from: weatherData.date)
            self.date.value = weatherData.date
            self.icon.value = UIImage(named: weatherData.iconName)
            let temp = self.tempFormatter
            .string(from: weatherData.currentTemp as NSNumber) ?? ""
            self.summary.value = "\(weatherData.description) - \(temp)℉"
            self.forecastSummary.value = "Summary: \(weatherData.description) forecast"
        }
    }
}
