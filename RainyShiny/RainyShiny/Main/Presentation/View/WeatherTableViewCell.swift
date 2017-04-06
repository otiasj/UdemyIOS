//
//  WeatherTableViewCell.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/4/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation
import UIKit


class WeatherTableViewCell : UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    
    
    func populateWith(model: CellModel) {
        weatherTypeLabel.text = model.formatedWeatherType
        if let weatherIconName = model.weatherType {
            weatherIcon.image = UIImage(named: weatherIconName)
        } else {
            weatherIcon.backgroundColor = UIColor.red
        }
        lowTemperatureLabel.text = model.formatedLowCelsiusTemperature
        highTemperatureLabel.text = model.formatedHighCelsiusTemperature
        dayLabel.text = model.formatedDate
    }
}
