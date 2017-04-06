//
//  TemperatureUtils.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/6/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation


extension Double {
    //Returns the current Kelvin value in to Celsius
    func fromKelvinToCelsius() -> Double {
        return self - 273.15
    }
    
    //Returns the current Kelvin value in to Fahrenheit
    mutating func fromKelvinToFahrenheit() -> Double {
        let kelvins = (self * (9/5) - 459.67)
        return Double(Darwin.round(10 * kelvins / 10))
    }
}
