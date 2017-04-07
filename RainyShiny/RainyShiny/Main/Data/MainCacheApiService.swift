//
//  MainCacheApiService.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainCacheApiService: ApiService {
    
    let preferences : Preferences
    
    init(preferences : Preferences) {
        self.preferences = preferences
    }
    
    /**
     * Load some data from cache, if the data in cache is today
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        
        let observable = Observable<MainEntity>.create { observer in
            let disposable = workScheduler.schedule(()) {
                self.loadWeatherFromCache(observer : observer)
                return workScheduler.schedule(()) {
                    observer.onCompleted()
                    return Disposables.create()
                }
            }
            return Disposables.create {
                print("Disposed cache observable")
                //clean up if any
                disposable.dispose()
            }
        }
        return observable
    }
    
    internal func loadWeatherFromCache(observer: AnyObserver<MainEntity>) {
        if let data = UserDefaults.standard.data(forKey: "mainEntity"),
            let mainEntity = NSKeyedUnarchiver.unarchiveObject(with: data) as? MainEntity,
            NSCalendar.current.isDateInToday(mainEntity.downloadedDate!) {
            print("Using cache!")
            return observer.onNext(mainEntity)
        }
    }
    
    func store(_ value: MainEntity, withParams: NSDictionary) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(encodedData, forKey: "mainEntity")
    }
    
    func clear(withParams: NSDictionary) {
        UserDefaults.standard.removeObject(forKey: "mainEntity")
    }
}
