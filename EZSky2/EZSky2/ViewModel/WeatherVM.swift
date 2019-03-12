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
        self.currentTemp = String(weather.currentTemp) + "°"
        self.icon = weather.icon.iconNameFromIconCode()
    }
    
}
