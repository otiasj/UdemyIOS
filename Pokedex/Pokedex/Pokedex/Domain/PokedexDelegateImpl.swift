//
//  PokedexDelegateImpl.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation
import RxSwift

class PokedexDelegateImpl : PokedexDelegate {
    
    let pokedexCacheApiService: PokedexCacheApiService
    let pokedexNetworkApiService: PokedexNetworkApiService
    
    // MARK: lifecycle
    init(pokedexCacheApiService: PokedexCacheApiService,
         pokedexNetworkApiService: PokedexNetworkApiService) {
        self.pokedexCacheApiService = pokedexCacheApiService
        self.pokedexNetworkApiService = pokedexNetworkApiService
    }
    
    // MARK: - logic
    func load(params: [String: Any?]) -> Observable<PokedexModel> {
        let cacheObservable = pokedexCacheApiService.load(withParams: params)
        let networkObservable = pokedexNetworkApiService.load(withParams: params)
        
        return Observable<PokedexEntity>
            .concat([cacheObservable, networkObservable]) // try first on cache, then network
            .take(1) // take the first non empty event (first does not exist in rxswift?!)
            .map { entity in return PokedexModel(from: entity) } // create a Model wrapping the received entity
            .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
    }
}
