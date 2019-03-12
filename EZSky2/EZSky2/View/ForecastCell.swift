//
//  ForecastCell.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var weatherIconIV: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    var forecastVM: ForecastVM! {
        didSet {
            weatherIconIV.image = UIImage(named: forecastVM.icon)
            dayLbl.text = forecastVM.day
            weatherTypeLbl.text = forecastVM.weatherType
            maxTempLbl.text = forecastVM.maxTemp
            minTempLbl.text = forecastVM.minTemp
        }
    }
    
}
