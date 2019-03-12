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
    @IBOutlet weak var tableView: UITableView!
    
    // refresh control allows pull tableview to update UI
    private let refreshControl = UIRefreshControl()
    
    let location = Location.shared
    let networkService = NetworkService.shared
    let locationManager = CLLocationManager()
    
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
    
   var forecastVMs = [ForecastVM]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWeatherView()
        setupTableView()
        setupLocationManager()
    }
    
    
    private func setupWeatherView() {
        weatherView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0
        
        // assign refreshControl to the tableView and configure it
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refreshData(sender:)), for: .valueChanged)
    }
    
    @objc private func refreshData(sender: Any) {
        // to refresh the data, we start by calling getLocation() again
        getLocation()
    }
    
    private func getData() {
    
        networkService.getWeather { (weather, error) in
            if let error = error {
                print("Failed to get weather: ", error)
                return
            }
            
            guard let weather = weather else { return }
            print("we got the weather")
            self.weatherView.weatherVM = WeatherVM(weather: weather)
            
            // update UI on main thread
            DispatchQueue.main.async {
                self.weatherView.isHidden = false
            }
        }
        
        networkService.getForecast { (forecasts, error) in
            if let error = error {
                print("Failed to get forecast: ", error)
                // update UI on main thread
                DispatchQueue.main.async {
                    // show error alert to user
                    let message = error.localizedDescription
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default,  handler: nil))
                    self.present(alert, animated: true, completion: {
                        // stop resresh spinner if one was active
                        self.refreshControl.endRefreshing()
                    })
                }
                return
            }
            
            self.forecastVMs = forecasts?.map({return ForecastVM(forecast: $0)}) ?? []
    
            // update UI on main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                // if we were updating from a pull-to-refresh, we end refreshing
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    // MARK: - Location
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func getLocation() {
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
        return forecastVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
      
        let forecastVM = forecastVMs[indexPath.row]
        cell.forecastVM = forecastVM
        return cell
    }
}
