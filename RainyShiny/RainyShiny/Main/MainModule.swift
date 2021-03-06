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
    private static let API_KEY = "0f3f4bc9aea43c795f75e7bb14c3f6fe"
    
    //Be careful in the order of the creation of instances
    init(mainView: MainView) {
        self.mainView = mainView
        self.mainDelegate = MainModule.provideMainDelegate()
        self.weatherTableAdapter = WeatherTableAdapter()
        self.mainPresenter = MainPresenterImpl(mainView: mainView,
                                               mainDelegate: mainDelegate,
                                               weatherTableAdapter: weatherTableAdapter)
    }
    
    func provideMainPresenter() -> MainPresenter {
       return mainPresenter
    }
    
    func provideWeatherTableAdapter() -> WeatherTableAdapter {
        return weatherTableAdapter
    }
    
    internal static func provideMainDelegate() -> MainDelegateImpl {
        return MainDelegateImpl(mainCacheApiService: provideMainCacheApiService(),
                                mainNetworkApiService: provideMainNetworkApiService(),
                                forecastNetworkApiService: provideForecastNetworkApiService(),
                                locationService: provideLocationService())
    }
    
    internal static func provideMainCacheApiService() -> MainCacheApiService {
        return MainCacheApiService(preferences: Preferences())
    }
    
    internal static func provideMainNetworkApiService() -> MainNetworkApiService {
        return MainNetworkApiService(apiKey: API_KEY)
    }
    
    internal static func provideForecastNetworkApiService() -> ForecastNetworkApiService {
        return ForecastNetworkApiService(apiKey: API_KEY)
    }
    
    internal static func provideLocationService() -> LocationService {
        return LocationService()
    }

}
