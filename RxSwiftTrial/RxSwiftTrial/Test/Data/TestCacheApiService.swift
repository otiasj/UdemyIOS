//
//  TestCacheApiService.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/17/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class TestCacheApiService: ApiService {
    
    /**
     * Load some data from (core data?)
     */
    func load(withParams: NSDictionary) -> Observable<TestEntity>{
//        return Observable<TestEntity>.just(TestEntity(loadedFrom: "Cache"))
        return Observable<TestEntity>.empty() //emulate no cache
    }
    
}
