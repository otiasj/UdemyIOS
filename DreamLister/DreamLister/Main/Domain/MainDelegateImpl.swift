//
//  MainDelegateImpl.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift

class MainDelegateImpl : MainDelegate {
    let itemCoreDataService: ItemCoreDataService
    
    // MARK: lifecycle
    init(itemCoreDataService: ItemCoreDataService) {
        self.itemCoreDataService = itemCoreDataService
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<MainModel> {
        return itemCoreDataService.load(withParams: params)
            .map { entity in return MainModel(from: entity) } // create a Model wrapping the received entity
            .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
    }
}
