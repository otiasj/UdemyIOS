//
//  DetailsModule.swift
//  DreamLister
//
//  This class is in charge of initializing and creating instances for this feature
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class DetailsModule {
    
    //the instances
    private let detailsView: DetailsView
    private let detailsPresenter: DetailsPresenter
    private let detailsDelegate: DetailsDelegate
    private let storePickerAdapter: StorePickerAdapter
    
    //Be careful in the order of the creation of instances
    init(detailsView: DetailsView) {
        self.detailsView = detailsView
        self.storePickerAdapter = StorePickerAdapter()
        self.detailsDelegate = DetailsDelegateImpl(storeCoreDataService: StoreCoreDataService(), itemCoreDataService : ItemCoreDataService())
        self.detailsPresenter = DetailsPresenterImpl(detailsView: detailsView, detailsDelegate: detailsDelegate, storePickerAdapter: storePickerAdapter)
        
    }
    
    func provideDetailsPresenter() -> DetailsPresenter {
       return detailsPresenter
    }
    
    func provideStorePickerAdapter() -> StorePickerAdapter {
        return storePickerAdapter
    }
}
