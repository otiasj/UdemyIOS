//
//  DetailsComponent.swift
//  DreamLister
//
//  The component tracks the lifecycle of objects instantiated in module
//  this is usefull in the case where we could have shared instances, between or accross features
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class DetailsComponent {
    
    private static var detailsModule: DetailsModule?
    
    func inject(detailsView: DetailsViewController) {
        DetailsComponent.detailsModule = DetailsModule(detailsView: detailsView)
        if let detailsModule = DetailsComponent.detailsModule {
            detailsView.detailsPresenter = detailsModule.provideDetailsPresenter()
            detailsView.storePickerAdapter = detailsModule.provideStorePickerAdapter()
        }
    }
}
