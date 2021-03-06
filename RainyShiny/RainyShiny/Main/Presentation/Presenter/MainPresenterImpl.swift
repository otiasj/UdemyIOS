//
//  MainPresenterImpl.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainPresenterImpl: MainPresenter
{
    let disposeBag = DisposeBag()
    let mainView: MainView
    let mainDelegate: MainDelegate
    let weatherTableAdapter: WeatherTableAdapter
    
    var isLoading = false
    
    // MARK: lifecycle
    init(mainView: MainView,
        mainDelegate: MainDelegate,
        weatherTableAdapter: WeatherTableAdapter) {
        self.mainView = mainView
        self.mainDelegate = mainDelegate
        self.weatherTableAdapter = weatherTableAdapter
        
        let emptyModel = MainModel()
        updateUiWith(emptyModel)
    }
    
    // MARK: - main presenter logic
    func load()
    {
        if (!isLoading) {
            isLoading = true
            mainView.showLoading()
            mainDelegate.load()
                .subscribe(
                    onNext: { mainModel in
                        print("onNext")
                        self.onResponse(mainModel)
                },
                    onError: { error in
                        print(error)
                        self.onError(error)
                },
                    onCompleted: {
                        print("Completed")
                        self.onComplete()
                },
                    onDisposed: {
                        print("Disposed")
                }
                )
                .addDisposableTo(disposeBag)
        } else {
            mainView.showErrorMessage("Already Loading")
        }
    }
    
    func refresh() {
        mainDelegate.clearCache()
        load()
    }
    
    // MARK: - load Event handling
    func onResponse(_ mainModel: MainModel) {
        updateUiWith(mainModel)
    }
    
    func updateUiWith(_ mainModel: MainModel) {
        mainView.setCity(cityName: mainModel.formatedCityName)
        mainView.setDate(formatedDate: mainModel.formatedDate)
        mainView.setCurrentTemperature(currentTemperature: mainModel.formatedCelsiusTemperature)
        mainView.setWeatherType(weatherType: mainModel.formatedWeatherType)
        if let forecasts = mainModel.forecasts {
            weatherTableAdapter.setWeatherData(forecasts: forecasts as? [CellModel])
        }
    }
    
    func onError(_ error: Error) {
        mainView.hideLoading()
        mainView.showErrorMessage(error.localizedDescription)
        isLoading = false
    }
    
    func onComplete()
    {
        mainView.hideLoading()
        isLoading = false
    }
}
