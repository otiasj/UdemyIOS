//
//  TestCacheApiService.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/20/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class TestCacheApiService: ApiService {
    
    /**
     * Load some data from cache
     */
    func load(withParams: NSDictionary?) -> Observable<TestEntity>{
        //FIXME this is returning a mock response
        return Observable<TestEntity>.just(TestEntity(loadedFrom: "Cache"))
//        return Observable<TestEntity>.empty() //emulate no cache
    }
    
}
