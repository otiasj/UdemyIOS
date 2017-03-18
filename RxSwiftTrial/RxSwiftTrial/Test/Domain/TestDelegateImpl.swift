//
//  TestDelegateImpl.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/17/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift

class TestDelegateImpl : TestDelegate {
    var subject: ReplaySubject<TestModel>?
    let disposeBag = DisposeBag()
    let testCacheApiService: TestCacheApiService
    let testNetworkApiService: TestNetworkApiService
    
    // MARK: lifecycle
    init(testCacheApiService: TestCacheApiService,
         testNetworkApiService: TestNetworkApiService) {
        self.testCacheApiService = testCacheApiService
        self.testNetworkApiService = testNetworkApiService
        
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<TestModel> {
        if subject == nil {
            self.subject = ReplaySubject.create(bufferSize: 2)
            
            let cacheObservable = testCacheApiService.load(withParams: params)
            let networkObservable = testNetworkApiService.load(withParams: params)
            
            Observable<TestEntity>
                .concat(cacheObservable, networkObservable) // try first on cache, then network
                .take(1) // take the first non empty event (first does not exist in rxswift?!)
                .map { entity in return TestModel(from: entity) } // create a new Model wrapping the received entity
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)) // Subscribe works in background thread
                .observeOn(MainScheduler()) // Observe result in main thread
                .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
                .addDisposableTo(disposeBag) // clean up after execution
        }
        
        return (self.subject?.asObservable())!
    }
}
