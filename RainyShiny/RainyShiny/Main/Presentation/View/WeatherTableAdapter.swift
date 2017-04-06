//
//  WeatherTableAdapter.swift
//  RainyShiny
//
//  Created by Julien Saito on 4/4/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView?
    var forecasts: [CellModel]?
    
    func initView(_ tableView : UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func setWeatherData(forecasts: [CellModel]?) {
        self.forecasts = forecasts
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecasts = self.forecasts {
            return forecasts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellModels = self.forecasts {
            let cellModel = cellModels[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            cell.populateWith(model: cellModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
