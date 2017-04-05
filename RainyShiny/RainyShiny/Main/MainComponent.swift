//
//  MainComponent.swift
//  RainyShiny
//
//  The component tracks the lifecycle of objects instantiated in module
//  this is usefull in the case where we could have shared instances, between or accross features
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainComponent {
    
    private static var mainModule: MainModule?
    
    func inject(mainView: MainViewController) {
        MainComponent.mainModule = MainModule(mainView: mainView)
        if let mainModule = MainComponent.mainModule {
            mainView.mainPresenter = mainModule.provideMainPresenter()
            mainView.weatherTableAdapter = mainModule.provideWeatherTableAdapter()
        }
    }
}
