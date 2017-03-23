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
    var subject: ReplaySubject<DetailsModel>?
    let disposeBag = DisposeBag()
    
    let detailsCacheApiService: DetailsCacheApiService
    let detailsNetworkApiService: DetailsNetworkApiService
    
    // MARK: lifecycle
    init(detailsCacheApiService: DetailsCacheApiService,
         detailsNetworkApiService: DetailsNetworkApiService) {
        self.detailsCacheApiService = detailsCacheApiService
        self.detailsNetworkApiService = detailsNetworkApiService
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<DetailsModel> {
        if subject == nil {
            self.subject = ReplaySubject.create(bufferSize: 2)
            
            let cacheObservable = detailsCacheApiService.load(withParams: params)
            let networkObservable = detailsNetworkApiService.load(withParams: params)
            
            Observable<DetailsEntity>
                .concat(cacheObservable, networkObservable) // try first on cache, then network
                .take(1) // take the first non empty event (first does not exist in rxswift?!)
                .map { entity in return DetailsModel(from: entity) } // create a Model wrapping the received entity
                .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
                .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
                .addDisposableTo(disposeBag) // clean up after execution
        }
        
        return (self.subject?.asObservable())!
    }
}
