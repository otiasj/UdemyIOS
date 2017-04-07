//
//  Forecast.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/5/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation

class Forecast: NSObject, NSCoding {
    var dateUnixTimestamp:Date?
    var weatherType: String?
    var weatherTypeDescription: String?
    var highTemperatureInKelvin: Double?
    var lowTemperatureInKelvin: Double?
    
    override init() {
    }
    
    init(copy: Forecast) {
        self.dateUnixTimestamp = copy.dateUnixTimestamp
        self.weatherType = copy.weatherType
        self.weatherTypeDescription = copy.weatherTypeDescription
        self.highTemperatureInKelvin = copy.highTemperatureInKelvin
        self.lowTemperatureInKelvin = copy.lowTemperatureInKelvin
    }
    
    required init?(coder aDecoder: NSCoder) {
        dateUnixTimestamp = aDecoder.decodeObject(forKey: "dateUnixTimestamp") as? Date
        weatherType = aDecoder.decodeObject(forKey: "weatherType") as? String
        weatherTypeDescription = aDecoder.decodeObject(forKey: "weatherTypeDescription") as? String
        highTemperatureInKelvin = aDecoder.decodeObject(forKey: "highTemperatureInKelvin") as? Double
        lowTemperatureInKelvin = aDecoder.decodeObject(forKey: "lowTemperatureInKelvin") as? Double
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(dateUnixTimestamp, forKey: "dateUnixTimestamp")
        coder.encode(weatherType, forKey: "weatherType")
        coder.encode(weatherTypeDescription, forKey: "weatherTypeDescription")
        coder.encode(highTemperatureInKelvin, forKey: "highTemperatureInKelvin")
        coder.encode(lowTemperatureInKelvin, forKey: "lowTemperatureInKelvin")
    }

}
