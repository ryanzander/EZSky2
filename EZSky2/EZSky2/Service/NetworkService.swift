//
//  NetworkService.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import UIKit

class NetworkService: NSObject {

    static let shared = NetworkService()

    func getWeather(completion: @escaping (Weather?, Error?) -> ()) {
        
        guard let url = URL(string: WEATHER_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // handle error
            if let error = error {
                completion(nil, error)
                print("Failed to get weather: ", error)
                return
            }
            // check response
            guard let data = data else { return }
            
            // parse the result as JSON
            do {
                guard let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                var weatherType = ""
                var weatherDetails = ""
                var icon = ""
                var currentTemp = 0
                let cityName = (dic["name"] as? String ?? "").capitalized
                if let weatherDic = dic["weather"] as? [[String: AnyObject]] {
                    weatherType = (weatherDic[0]["main"] as? String ?? "").capitalized
                    weatherDetails = (weatherDic[0]["description"] as? String ?? "").capitalizingFirstLetter()
                    icon = weatherDic[0]["icon"] as? String ?? ""
                }
                
                if let main = dic["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        // the API gives temp in kelvins, so we convert to celsius
                        currentTemp = Int(round(currentTemperature - 273.15))
                    }
                }
                
                let weather = Weather.init(cityName: cityName, weatherType: weatherType, weatherDetails: weatherDetails, icon: icon, currentTemp: currentTemp)
                
                completion(weather, error)
                return
               
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }.resume()
    }
    
    
    func getForecast(completion: @escaping ([Forecast]?, Error?) -> ()) {
        
        guard let url = URL(string: FORECAST_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(nil, error)
                print("Failed to get forecast: ", error)
                return
            }
            // check response
            guard let data = data else { return }
            
            // parse the result as JSON
            do {
                guard let dic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                if let list = dic["list"] as? [[String: AnyObject]] {
                    // api gives an array of forecast dictionaries
                    var forecasts = [Forecast]()
                    
                    for dic in list {
                        
                        var day = ""
                        var weatherType = ""
                        var icon = ""
                        var maxTemp = 0
                        var minTemp = 0
                        
                        if let dt = dic["dt"] as? Double {
                            let date = Date(timeIntervalSince1970: dt)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .short
                            dateFormatter.timeStyle = .none
                            day = date.dayOfWeek() ?? ""
                        }
                        
                        if let weather = dic["weather"] as? [[String: AnyObject]] {
                            
                            if let details = weather[0]["description"] as? String {
                                weatherType = details.capitalizingFirstLetter()
                            }
                            
                            if let iconName = weather[0]["icon"] as? String {
                                icon = iconName
                            }
                        }
                        
                        if let temp = dic["temp"] as? [String: AnyObject] {
                            // temp data is in kelvins, so we subtract to get degrees Celsius
                            if let min = temp["min"] as? Double {
                                minTemp = Int(round(min - 273.15))
                            }
                            
                            if let max = temp["max"] as? Double {
                                maxTemp = Int(round(max - 273.15))
                            }
                        }
                        
                        let forecast = Forecast.init(day: day, weatherType: weatherType, icon: icon, maxTemp: maxTemp, minTemp: minTemp)
                        forecasts.append(forecast)
                        
                    }
                    completion(forecasts, error)
                    return
                }
                
            } catch {
                print("error trying to convert data to JSON")
                return
            }
        }.resume()
    }
    
}
