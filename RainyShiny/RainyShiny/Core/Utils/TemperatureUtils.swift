//
//  TemperatureUtils.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/6/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation


extension Double {
    
    func roundNearest(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    //Returns the current Kelvin value in to Celsius
    func fromKelvinToCelsius() -> Double {
        let celsius = self - 273.15
        return celsius.roundNearest(nearest: 0.5)
    }
    
    //Returns the current Kelvin value in to Fahrenheit
    func fromKelvinToFahrenheit() -> Double {
        let kelvins = (self * (9/5) - 459.67)
        return kelvins.roundNearest(nearest: 0.25)
    }
}
