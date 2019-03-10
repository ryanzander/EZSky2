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
}
