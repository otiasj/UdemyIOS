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
        if let data = UserDefaults.standard.data(forKey: "mainEntity"),
            let mainEntity = NSKeyedUnarchiver.unarchiveObject(with: data) as? MainEntity,
            NSCalendar.current.isDateInToday(mainEntity.downloadedDate!) {
            print("Using cache!")
            return Observable<MainEntity>.just(mainEntity)
        } else {
            return Observable<MainEntity>.empty()
        }
    }
    
    func store(_ value: MainEntity, withParams: NSDictionary) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(encodedData, forKey: "mainEntity")
    }
}
