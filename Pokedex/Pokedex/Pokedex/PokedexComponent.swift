//
//  PokedexComponent.swift
//  Pokedex
//
//  The component tracks the lifecycle of objects instantiated in module
//  this is usefull in the case where we could have shared instances, between or accross features
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class PokedexComponent {
    
    private static var pokedexModule: PokedexModule?
    
    func inject(pokedexView: PokedexViewController) {
        PokedexComponent.pokedexModule = PokedexModule(pokedexView: pokedexView)
        if let pokedexModule = PokedexComponent.pokedexModule {
            pokedexView.pokedexPresenter = pokedexModule.providePokedexPresenter()
        }
    }
}
