//
//  MainModel.swift
//  RainyShiny
//
//  This class wraps the data loaded from the services, and provides presentation related data manipulation.
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation

class MainModel : MainEntity {
    
    override init() {
        super.init()
    }
    
    override init(copy: MainEntity) {
        super.init(copy: copy)
    }

    var formatedCityName: String {
        if let cityName = self.cityName {
            return cityName.capitalized
        } else {
            return "Unknown Location"
        }
    }
    
    var formatedDate: String {
        if let date = self.downloadedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: date)
            return "Today, \(currentDate)"
        } else {
            return "Date: ?"
        }
    }

    var formatedCelsiusTemperature: String {
        if let temperature = self.currentTemperatureInKelvin {
            let temperatureInCelsius = temperature.fromKelvinToCelsius()
            return NSString(format: "%.2f°C", temperatureInCelsius) as String
        } else {
            return "??.??°C"
        }
    }
    
    var formatedWeatherType: String {
        if let weatherType = self.weatherType {
            return weatherType.capitalized
        } else {
            return ""
        }
    }
}
