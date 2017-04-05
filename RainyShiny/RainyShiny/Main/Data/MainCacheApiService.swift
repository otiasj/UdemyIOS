//
//  MainCacheApiService.swift
//  RainyShiny
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainCacheApiService: ApiService {
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        //FIXME this is returning a mock response
//        return Observable<MainEntity>.just(MainEntity(copy: "Cache"))
        return Observable<MainEntity>.empty() //emulate no cache
    }
    
}
