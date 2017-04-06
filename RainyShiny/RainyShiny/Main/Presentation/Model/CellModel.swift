//
//  CellModel.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/5/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation

class CellModel : Forecast {
    
    override init() {
        super.init()
    }
    
    override init(copy: Forecast) {
        super.init(copy: copy)
    }
    
    var formatedHighCelsiusTemperature: String {
        if let temperature = self.highTemperatureInKelvin {
            return NSString(format: "%.2f°C", temperature.fromKelvinToCelsius()) as String
        } else {
            return "??.??°C"
        }
    }
    
    var formatedLowCelsiusTemperature: String {
        if let temperature = self.lowTemperatureInKelvin {
            return NSString(format: "%.2f°C", temperature.fromKelvinToCelsius()) as String
        } else {
            return "??.??°C"
        }
    }

    var formatedDate: String {
        if let unixTimestamp = self.dateUnixTimestamp {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: unixTimestamp)
        } else {
            return ""
        }
    }
    
    var formatedWeatherType: String {
        if let weatherType = self.weatherTypeDescription {
            return weatherType.capitalized
        } else {
            return ""
        }
    }
}
