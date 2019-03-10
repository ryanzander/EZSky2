//
//  WeatherView.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var weatherIconIV: UIImageView!

    var weatherVM: WeatherVM! {
        didSet {
            // update UI on main thread
            DispatchQueue.main.async {
                self.dateLbl.text = self.weatherVM.date
                self.cityLbl.text = self.weatherVM.cityName
                self.tempLbl.text = self.weatherVM.currentTemp + "°"
                self.detailsLbl.text = self.weatherVM.weatherDetails
                self.weatherIconIV.image = UIImage(named: self.weatherVM.icon)
            }
        }
    }
}
