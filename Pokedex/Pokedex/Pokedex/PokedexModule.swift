//
//  PokedexModule.swift
//  Pokedex
//
//  This class is in charge of initializing and creating instances for this feature
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class PokedexModule {
    
    //the instances
    private let pokedexView: PokedexView
    private let pokedexPresenter: PokedexPresenter
    private let pokedexDelegate: PokedexDelegate
    private let preferences: Preferences
    
    //Be careful in the order of the creation of instances
    init(pokedexView: PokedexView) {
        self.preferences = PokedexModule.providePreferences()
        self.pokedexView = pokedexView
        self.pokedexDelegate = PokedexModule.providePokedexDelegate(preferences: preferences)
        self.pokedexPresenter = PokedexPresenterImpl(pokedexView: pokedexView, pokedexDelegate: pokedexDelegate)
    }
    
    func providePokedexPresenter() -> PokedexPresenter {
       return pokedexPresenter
    }
    
    internal static func providePokedexDelegate(preferences: Preferences) -> PokedexDelegateImpl {
        return PokedexDelegateImpl(pokedexCacheApiService: providePokedexCacheApiService(preferences: preferences), pokedexNetworkApiService: providePokedexNetworkApiService())
    }
    
    internal static func providePokedexCacheApiService(preferences: Preferences) -> PokedexCacheApiService {
        return PokedexCacheApiService(preferences: preferences)
    }
    
    internal static func providePokedexNetworkApiService() -> PokedexNetworkApiService {
        return PokedexNetworkApiService()
    }
 
    internal static func providePreferences() -> Preferences {
        return Preferences()
    }
}
