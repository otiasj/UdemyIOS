//
//  DetailsDelegateImpl.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift

class DetailsDelegateImpl : DetailsDelegate {
    
    let storeCoreDataService: StoreCoreDataService
    let itemCoreDataService: ItemCoreDataService
    
    // MARK: lifecycle
    init(storeCoreDataService: StoreCoreDataService, itemCoreDataService: ItemCoreDataService) {
        self.storeCoreDataService = storeCoreDataService
        self.itemCoreDataService = itemCoreDataService
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<[Store]> {
        return storeCoreDataService.load(withParams: params)
                .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
    }
    
    //saves an item
    func save(_ detailEntity: DetailsEntity) {
        itemCoreDataService.save(detailsEntity: detailEntity)
    }
}
