//
//  MainEntity.swift
//  RainyShiny
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainEntity {
    
    var cityName: String?
    var date: String?
    var weatherType: String?
    var currentTemperature: Double?
    
    init() {
    }
    
    init(copy: MainEntity) {
        self.cityName = copy.cityName
        self.date = copy.date
        self.weatherType = copy.weatherType
        self.currentTemperature = copy.currentTemperature
    }
}
