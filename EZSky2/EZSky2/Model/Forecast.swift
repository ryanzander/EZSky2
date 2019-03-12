//
//  Forecast.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

struct Forecast {
    
    let day: String
    let weatherType: String
    let icon: String
    let maxTemp: Int
    let minTemp: Int
    
    init(day: String, weatherType: String, icon: String, maxTemp: Int, minTemp: Int) {
        
        self.day = day
        self.weatherType = weatherType
        self.icon = icon
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
}


