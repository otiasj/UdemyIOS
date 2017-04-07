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
    let locationService: LocationService
    
    // MARK: lifecycle
    init(mainCacheApiService: MainCacheApiService,
         mainNetworkApiService: MainNetworkApiService,
         forecastNetworkApiService: ForecastNetworkApiService,
         locationService: LocationService) {
        self.mainCacheApiService = mainCacheApiService
        self.mainNetworkApiService = mainNetworkApiService
        self.forecastNetworkApiService = forecastNetworkApiService
        self.locationService = locationService
    }
    
    // MARK: - logic
    func load() -> Observable<MainModel> {
        if subject == nil {
            self.subject = ReplaySubject.create(bufferSize: 2)
            let cacheObservable = mainCacheApiService.load(withParams: ["":""])
            let locationObservable = locationService.loadCurrentLocation()
            
            let locationAndNetworkObservable = locationObservable.flatMap { location in
                    return self.getMainEntityFromNetwork(latitude: location.latitude, longitude: location.longitude)
            }
            
            Observable<MainEntity>
                .concat(cacheObservable, locationAndNetworkObservable) // try first on cache, then network
                .take(1) // take the first non empty event
                .map { entity in
                    self.mainCacheApiService.store(entity, withParams: ["":""])
                    return MainModel(copy: entity)  // create a Model wrapping the received entity
                }
                .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
                .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
                .addDisposableTo(disposeBag) // clean up after execution
        }
        
        return (self.subject?.asObservable())!
    }
    
    //Fetch the current weather and forecast for given location
    internal func getMainEntityFromNetwork(latitude: Double, longitude: Double) -> Observable<MainEntity> {
        let params = ["latitude": latitude, "longitude": longitude, "forecastDayCount": 10] as NSDictionary
        let mainNetworkObservable = mainNetworkApiService.load(withParams: params)
        let forecastNetworkObservable = forecastNetworkApiService.load(withParams: params)
        
        return Observable<MainEntity>.zip(mainNetworkObservable, forecastNetworkObservable) {
            mainEntity, forecasts in
            return self.combineNetworkResponses(mainEntity: mainEntity, forecasts: forecasts)
        }
    }

    //add the forecasts into the mainEntity as CellModel wrappers
    internal func combineNetworkResponses(mainEntity: MainEntity, forecasts: [Forecast]) -> MainEntity {
        mainEntity.forecasts = [CellModel]()
        for forecast in forecasts {
            mainEntity.forecasts?.append(CellModel(copy: forecast))
        }
        return mainEntity
    }
}
