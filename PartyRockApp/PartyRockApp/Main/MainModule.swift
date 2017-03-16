//
//  This class is in charge of initializing and creating instance of the different pieces needed in this feature
//  MainModule.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation

class MainModule: NSObject {
    
    //the instances
    private let mainView: MainView;
    private let partyRockTableAdapter: PartyRockTableAdapter;
    private let mainPresenter: MainPresenter;
    
    //Be careful in the order of the creation of instances
    init(mainView: MainView) {
        self.mainView = mainView
        partyRockTableAdapter = PartyRockTableAdapter()
        mainPresenter = MainPresenterImpl(mainView: mainView, partyRockTableAdapter: partyRockTableAdapter)
    }
    
    func providePartyRockTableAdapter() -> PartyRockTableAdapter {
        return partyRockTableAdapter
    }

    func provideMainPresenter() -> MainPresenter {
       return mainPresenter
    }
    
}
