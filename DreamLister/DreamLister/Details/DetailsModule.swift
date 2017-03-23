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
    
    //Be careful in the order of the creation of instances
    init(detailsView: DetailsView) {
        self.detailsView = detailsView
        self.detailsDelegate = DetailsModule.provideDetailsDelegate()
        self.detailsPresenter = DetailsPresenterImpl(detailsView: detailsView, detailsDelegate: detailsDelegate)
    }
    
    func provideDetailsPresenter() -> DetailsPresenter {
       return detailsPresenter
    }
    
    internal static func provideDetailsDelegate() -> DetailsDelegateImpl {
        return DetailsDelegateImpl(detailsCacheApiService: provideDetailsCacheApiService(), detailsNetworkApiService: provideDetailsNetworkApiService())
    }
    
    internal static func provideDetailsCacheApiService() -> DetailsCacheApiService {
        return DetailsCacheApiService()
    }
    
    internal static func provideDetailsNetworkApiService() -> DetailsNetworkApiService {
        return DetailsNetworkApiService()
    }
    
}
