//
//  TestNetworkApiService.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/17/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class TestNetworkApiService: ApiService {
    typealias T = TestEntity
    typealias P = NSDictionary

    /**
     * Load some data from the network
     */
    func load(withParams: NSDictionary) -> Observable<TestEntity>{
        return Observable<TestEntity>.just(TestEntity(loadedFrom: "Network"))
    }
    
}
