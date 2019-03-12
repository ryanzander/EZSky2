//
//  EZSky2Tests.swift
//  EZSky2Tests
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import XCTest
@testable import EZSky2

class EZSky2Tests: XCTestCase {
    
    func testStringCapitalizing() {
        
        let string = "sky is clear"
        XCTAssertEqual(string.capitalizingFirstLetter(), "Sky is clear")
    }

    func testWeatherVM() {
      
        // init WeatherViewModels from mock weather models
        let weather1 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "03d", currentTemp: 10)
        let weather2 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "01d", currentTemp: 10)
        let weather3 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "11d", currentTemp: 10)
        let weather4 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "02d", currentTemp: 10)
        let weather5 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "13d", currentTemp: 10)
        let weather6 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "09d", currentTemp: 10)
        let weather7 = Weather(cityName: "City Name", weatherType: "Type", weatherDetails: "Details", icon: "xxx", currentTemp: 10)
        let weatherVM1 = WeatherVM(weather: weather1)
        let weatherVM2 = WeatherVM(weather: weather2)
        let weatherVM3 = WeatherVM(weather: weather3)
        let weatherVM4 = WeatherVM(weather: weather4)
        let weatherVM5 = WeatherVM(weather: weather5)
        let weatherVM6 = WeatherVM(weather: weather6)
        let weatherVM7 = WeatherVM(weather: weather7)
        
        // strings
        XCTAssertEqual(weather1.cityName, weatherVM1.cityName)
        XCTAssertEqual(weather1.weatherType, weatherVM1.weatherType)
        XCTAssertEqual(weather1.weatherDetails, weatherVM1.weatherDetails)
        XCTAssertEqual("\(weather1.currentTemp)°", weatherVM1.currentTemp)
        
        // icon names
        XCTAssertEqual(weatherVM1.icon, "Cloudy")
        XCTAssertEqual(weatherVM2.icon, "Sunny")
        XCTAssertEqual(weatherVM3.icon, "Lightning")
        XCTAssertEqual(weatherVM4.icon, "Partially Cloudy")
        XCTAssertEqual(weatherVM5.icon, "Snow")
        XCTAssertEqual(weatherVM6.icon, "Rainy")
        // default
        XCTAssertEqual(weatherVM7.icon, "Partially Cloudy")
    }

    func testForecastVM() {
    
        // init forecastViewModel from mock forecast model
        let forecast1 = Forecast(day: "Monday", weatherType: "Sky is clear", icon: "01d", maxTemp: 32, minTemp: 18)
       
        let forecastVM1 = ForecastVM.init(forecast: forecast1)
        
        XCTAssertEqual(forecastVM1.day, "Monday")
        XCTAssertEqual(forecastVM1.weatherType, "Sky is clear")
        XCTAssertEqual(forecastVM1.icon, "Sunny")
        XCTAssertEqual(forecastVM1.maxTemp, "32°")
        XCTAssertEqual(forecastVM1.minTemp, "18°")
    }

}
