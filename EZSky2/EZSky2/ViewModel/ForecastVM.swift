//
//  ForecastVM.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

struct ForecastVM {
    
    let day: String
    let weatherType: String
    let icon: String
    let maxTemp: String
    let minTemp: String 
    
    // dependency injection
    init(forecast: Forecast) {
        
        self.day = forecast.day
        self.weatherType = forecast.weatherType
        self.icon = forecast.icon.iconNameFromIconCode()
        self.maxTemp = "\(forecast.maxTemp)°"
        self.minTemp = "\(forecast.minTemp)°"
    }
}
