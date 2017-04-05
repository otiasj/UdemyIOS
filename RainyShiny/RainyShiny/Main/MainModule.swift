//
//  MainModule.swift
//  RainyShiny
//
//  This class is in charge of initializing and creating instances for this feature
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainModule {
    
    //the instances
    private let mainView: MainView
    private let mainPresenter: MainPresenter
    private let mainDelegate: MainDelegate
    private let weatherTableAdapter: WeatherTableAdapter
    
    //Be careful in the order of the creation of instances
    init(mainView: MainView) {
        self.mainView = mainView
        self.mainDelegate = MainModule.provideMainDelegate()
        self.weatherTableAdapter = WeatherTableAdapter()
        self.mainPresenter = MainPresenterImpl(mainView: mainView, mainDelegate: mainDelegate, weatherTableAdapter: weatherTableAdapter)
    }
    
    func provideMainPresenter() -> MainPresenter {
       return mainPresenter
    }
    
    func provideWeatherTableAdapter() -> WeatherTableAdapter {
        return weatherTableAdapter
    }
    
    internal static func provideMainDelegate() -> MainDelegateImpl {
        return MainDelegateImpl(mainCacheApiService: provideMainCacheApiService(), mainNetworkApiService: provideMainNetworkApiService())
    }
    
    internal static func provideMainCacheApiService() -> MainCacheApiService {
        return MainCacheApiService()
    }
    
    internal static func provideMainNetworkApiService() -> MainNetworkApiService {
        return MainNetworkApiService()
    }
}
