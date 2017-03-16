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
    
    private static var mainModule: MainModule?
    
    func inject(mainView: MainViewController) {
        MainComponent.mainModule = MainModule(mainView: mainView)
        if let mainModule = MainComponent.mainModule {
            mainView.mainPresenter = mainModule.provideMainPresenter()
            mainView.partyRockTableAdapter = mainModule.providePartyRockTableAdapter()
        }
    }
}
