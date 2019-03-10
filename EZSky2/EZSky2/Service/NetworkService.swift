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
        //let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
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
                print(dic)
                
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
    
    
}
