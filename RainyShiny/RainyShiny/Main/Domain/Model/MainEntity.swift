//
//  MainEntity.swift
//  RainyShiny
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
import Foundation

class MainEntity: NSObject, NSCoding {
    
    var cityName: String?
    var downloadedDate: Date?
    var weatherType: String?
    var currentTemperatureInKelvin: Double?
    var forecasts: [Forecast]?
    
    override init() {
    }
    
    init(copy: MainEntity) {
        self.cityName = copy.cityName
        self.downloadedDate = copy.downloadedDate
        self.weatherType = copy.weatherType
        self.currentTemperatureInKelvin = copy.currentTemperatureInKelvin
        self.forecasts = copy.forecasts
    }
    
    required init?(coder aDecoder: NSCoder) {
        cityName = aDecoder.decodeObject(forKey: "cityName") as? String
        downloadedDate = aDecoder.decodeObject(forKey: "downloadedDate") as? Date
        weatherType = aDecoder.decodeObject(forKey: "weatherType") as? String
        currentTemperatureInKelvin = aDecoder.decodeObject(forKey: "currentTemperatureInKelvin") as? Double
        forecasts = aDecoder.decodeObject(forKey: "forecasts") as? [Forecast]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cityName, forKey: "cityName")
        coder.encode(downloadedDate, forKey: "downloadedDate")
        coder.encode(weatherType, forKey: "weatherType")
        coder.encode(currentTemperatureInKelvin, forKey: "currentTemperatureInKelvin")
        coder.encode(forecasts, forKey: "forecasts")
    }
}
