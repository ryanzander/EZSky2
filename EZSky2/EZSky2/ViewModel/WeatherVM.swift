//
//  WeatherVM.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

struct WeatherVM {
    
    let cityName: String
    let date: String
    let weatherType: String
    let weatherDetails: String
    let icon: String
    let currentTemp: String
    
    // dependency injection
    init(weather: Weather) {
        
        self.cityName = weather.cityName
        self.date = weather.date
        self.weatherType = weather.weatherType
        self.weatherDetails = weather.weatherDetails
        self.currentTemp = String(weather.currentTemp)
        
        // weather api returns coded icon names, so we match these with our weather images
        var imageName = ""
        switch weather.icon {
            
        case "03d", "03n", "04d", "04n", "50d", "50n":
            imageName = "Cloudy"
        case "01d", "01n":
            imageName = "Sunny"
        case "11d", "11n":
            imageName = "Lightning"
        case "02d", "02n":
            imageName = "Partially Cloudy"
        case "13d", "13n":
            imageName = "Snow"
        case "09d", "09n", "10d", "10n":
            imageName = "Rainy"
        default:
            imageName = "Partially Cloudy"
        }
        self.icon = imageName
    }
    
}
