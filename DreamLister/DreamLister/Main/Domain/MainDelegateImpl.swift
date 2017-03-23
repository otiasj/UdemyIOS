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
    var subject: ReplaySubject<MainModel>?
    let disposeBag = DisposeBag()
    
    let mainCoreDataService: MainCoreDataService
    let mainNetworkApiService: MainNetworkApiService
    
    // MARK: lifecycle
    init(mainCoreDataService: MainCoreDataService,
         mainNetworkApiService: MainNetworkApiService) {
        self.mainCoreDataService = mainCoreDataService
        self.mainNetworkApiService = mainNetworkApiService
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<MainModel> {
        if subject == nil {
            self.subject = ReplaySubject.create(bufferSize: 2)
            
            let cacheObservable = mainCoreDataService.load(withParams: params)
            let networkObservable = mainNetworkApiService.load(withParams: params)
            
            Observable<MainEntity>
                .concat(cacheObservable, networkObservable) // try first on cache, then network
                .take(1) // take the first non empty event (first does not exist in rxswift?!)
                .map { entity in return MainModel(from: entity) } // create a Model wrapping the received entity
                .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
                .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
                .addDisposableTo(disposeBag) // clean up after execution
        }
        
        return (self.subject?.asObservable())!
    }
}
