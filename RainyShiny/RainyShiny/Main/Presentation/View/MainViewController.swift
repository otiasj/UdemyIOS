//
//  MainViewController.swift
//  RainyShiny
//
//  Link your storyboard to this viewController
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class MainViewController: UIViewController, MainView
{
    
    let mainComponent = MainComponent()
    // MARK: - Injected
    var mainPresenter: MainPresenter?
    var weatherTableAdapter: WeatherTableAdapter?

    // MARK: - @IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainComponent.inject(mainView: self)
        weatherTableAdapter?.initView(tableView)
        mainPresenter?.load()
    }

    // MARK: - @IBAction
    @IBAction func onRefreshClicked(_ sender: Any) {
        mainPresenter?.refresh()
    }
    
    // MARK: - Display logic
    func setCity(cityName: String) {
        locationLabel.text = cityName
    }
    
    func setDate(formatedDate: String) {
        dateLabel.text = formatedDate
    }
    
    func setCurrentTemperature(currentTemperature : String) {
        temperatureLabel.text = currentTemperature
    }
    
    func setWeatherType(weatherType: String) {
        currentWeatherTypeLabel.text = weatherType
        weatherIconImage.image = UIImage(named: weatherType)
    }

    func showErrorMessage(_ errorMessage : String) {
        showToast(message: errorMessage)
    }
    
    func navigateToSettings() {
        print("Navigating to Settings")
        //performSegue(withIdentifier: "Settings", sender: self)
    }
    
    func showLoading() {
        print("Something is loading, show the spinner")
    }

    func hideLoading() {
        print("Something finished loading, hide the spinner")
    }
}
