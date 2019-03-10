//
//  Constants.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.openweathermap.org/data/2.5/"
let LAT = "lat="
let LON = "&lon="
let APP_ID = "&appid="
let API_KEY = "e853861efe7b26eed77d7cc7d36ba1d8"

// the latitude and longitude properties of our Location singleton are accessed here to create URLs specific to our current geographical location.
let WEATHER_URL = "\(BASE_URL)weather?\(LAT)\(Location.shared.latitude!)\(LON)\(Location.shared.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_URL = "\(BASE_URL)forecast/daily?\(LAT)\(Location.shared.latitude!)\(LON)\(Location.shared.longitude!)\(APP_ID)\(API_KEY)"
