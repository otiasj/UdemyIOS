//
//  DetailsNetworkApiService.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class DetailsNetworkApiService: ApiService {
    typealias T = DetailsEntity
    typealias P = NSDictionary

    /**
     * Load some data from the network
     */
    func load(withParams: NSDictionary) -> Observable<DetailsEntity>{
        //FIXME this is returning a mock response
        return Observable<DetailsEntity>.just(DetailsEntity(loadedFrom: "Network"))
    }
    
}
