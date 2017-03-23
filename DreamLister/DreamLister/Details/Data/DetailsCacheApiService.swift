//
//  DetailsCacheApiService.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class DetailsCacheApiService: ApiService {
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary) -> Observable<DetailsEntity>{
        //FIXME this is returning a mock response
        return Observable<DetailsEntity>.just(DetailsEntity(loadedFrom: "Cache"))
//        return Observable<TestEntity>.empty() //emulate no cache
    }
    
}
