//
//  MainDelegateImpl.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift

class MainDelegateImpl : MainDelegate {
    var subject: ReplaySubject<MainModel>?
    let disposeBag = DisposeBag()
    
    let mainCacheApiService: MainCacheApiService
    let mainNetworkApiService: MainNetworkApiService
    let forecastNetworkApiService: ForecastNetworkApiService
    
    // MARK: lifecycle
    init(mainCacheApiService: MainCacheApiService,
         mainNetworkApiService: MainNetworkApiService,
         forecastNetworkApiService: ForecastNetworkApiService) {
        self.mainCacheApiService = mainCacheApiService
        self.mainNetworkApiService = mainNetworkApiService
        self.forecastNetworkApiService = forecastNetworkApiService
    }
    
    // MARK: - logic
    func load(params: NSDictionary) -> Observable<MainModel> {
        if subject == nil {
            self.subject = ReplaySubject.create(bufferSize: 2)
            
            let cacheObservable = mainCacheApiService.load(withParams: params)
            let mainNetworkObservable = mainNetworkApiService.load(withParams: params)
            let forecastNetworkObservable = forecastNetworkApiService.load(withParams: params)
            
            //Fetch both api response and combine them
            let networkObservable = Observable<MainEntity>.zip(mainNetworkObservable, forecastNetworkObservable) {
                mainEntity, forecasts in
                mainEntity.forecasts = [CellModel]()
                for forecast in forecasts {
                    mainEntity.forecasts?.append(CellModel(copy: forecast))
                }
                return mainEntity
            }
            
            Observable<MainEntity>
                .concat(cacheObservable, networkObservable) // try first on cache, then network
                .take(1) // take the first non empty event
                .map { entity in return MainModel(copy: entity) } // create a Model wrapping the received entity
                .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
                .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
                .addDisposableTo(disposeBag) // clean up after execution
        }
        
        return (self.subject?.asObservable())!
    }
}
