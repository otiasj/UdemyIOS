//
//  MainView.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
//

protocol MainView {
    var mainPresenter: MainPresenter? { get set }
    
    func setCity(cityName: String)
    func setDate(formatedDate: String)
    func setCurrentTemperature(currentTemperature : String)
    func setWeatherType(weatherType:String)

    func showLoading()
    func hideLoading()
    func showErrorMessage(_ errorMessage : String)
}
