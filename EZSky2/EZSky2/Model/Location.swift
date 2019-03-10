//
//  Location.swift
//  EZSky2
//
//  Created by Ryan Zander on 3/9/19.
//  Copyright © 2019 Ryan Zander. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var shared = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
