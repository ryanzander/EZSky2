//
//  String+Extensions.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/10/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func iconNameFromIconCode() -> String {
        // weather api returns coded icon names, so we match these with our weather images
        var imageName = ""
        switch self {
            
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
        return imageName
    }
}
