//
//  The component tracks the lifecycle of objects instantiated in module
//  MainComponent.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation

class MainComponent {
    
    private let mainModule: MainModule
    
    init(mainView: MainView) {
         mainModule = MainModule(mainView: mainView)
    }
    
    // initialize the view properties
    func inject(mainViewToInject: MainView) {
        var mainViewToInject = mainViewToInject
        mainViewToInject.mainPresenter = mainModule.provideMainPresenter()
        mainViewToInject.partyRockTableAdapter = mainModule.providePartyRockTableAdapter()
    }
}
