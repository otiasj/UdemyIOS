//
//  MainModule.swift
//  DreamLister
//
//  This class is in charge of initializing and creating instances for this feature
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainModule {
    
    //the instances
    private let mainView: MainView
    private let itemTableViewAdapter: ItemTableViewAdapter;
    private let mainPresenter: MainPresenter
    private let mainDelegate: MainDelegate
    private let itemCoreDataService: ItemCoreDataService
    
    //Be careful in the order of the creation of instances
    init(mainView: MainView) {
        self.mainView = mainView
        self.itemTableViewAdapter = ItemTableViewAdapter()
        self.itemCoreDataService = ItemCoreDataService(onDataUpdateListener: itemTableViewAdapter)
        self.mainDelegate = MainDelegateImpl(itemCoreDataService: itemCoreDataService)
        self.mainPresenter = MainPresenterImpl(mainView: mainView, mainDelegate: mainDelegate, itemTableViewAdapter: itemTableViewAdapter)
    }
    
    func provideItemTableViewAdapter() -> ItemTableViewAdapter {
        return itemTableViewAdapter
    }
    
    func provideMainPresenter() -> MainPresenter {
       return mainPresenter
    }

}
