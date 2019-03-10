//
//  Weather.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

struct Weather {
    var cityName: String
    var date: String
    var weatherType: String
    var weatherDetails: String
    var icon: String
    var currentTemp: Int
    
    init(cityName: String, weatherType: String, weatherDetails: String, icon: String, currentTemp: Int) {
        self.cityName = cityName
        self.weatherType = weatherType
        self.weatherDetails = weatherDetails
        self.icon = icon
        self.currentTemp = currentTemp
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        let dateString = "Today, \(currentDate)"
        self.date = dateString
    }
}
