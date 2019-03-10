//
//  WeatherVC.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherView: WeatherView!
    
    let location = Location.shared
    let networkService = NetworkService.shared
    let locationManager = CLLocationManager()
    
    var weatherVM: WeatherVM?
 
    var currentLocation: CLLocation! {
        didSet {
            
            guard let currentLocation = currentLocation else { return }
            print("We got a location")
            
            // we assign the lat and long to our Location singleton class to access elsewhere
            location.latitude = currentLocation.coordinate.latitude
            location.longitude = currentLocation.coordinate.longitude
            
            getData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWeatherView()
        setupLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupWeatherView() {
        weatherView.isHidden = true
    }
    
    private func getData() {
    
        networkService.getWeather { (weather, error) in
            if let error = error {
                print("Failed to get weather:", error)
                return
            }
            
            guard let weather = weather else { return }
            print("we got the weather")
            self.weatherVM = WeatherVM(weather: weather)
            self.weatherView.weatherVM = self.weatherVM
            
            // update UI on main thread
            DispatchQueue.main.async {
                self.weatherView.isHidden = false
            }
        }
    }
    
    
    // MARK: - Location
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // if authorized, we get the device's location
            currentLocation = locationManager.location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            getLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            getLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }

    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            
            
            //let forecast = forecasts[indexPath.row]
            //cell.configureCell(forecast: forecast)
            return cell
            
        } else {
            return ForecastCell()
        }
    }
}
