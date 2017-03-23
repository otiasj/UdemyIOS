//
//  MainNetworkApiService.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainNetworkApiService: ApiService {
    typealias T = MainEntity
    typealias P = NSDictionary

    /**
     * Load some data from the network
     */
    func load(withParams: NSDictionary) -> Observable<MainEntity>{
        //FIXME this is returning a mock response
        return Observable<MainEntity>.just(MainEntity(loadedFrom: "Network"))
    }
    
}
