//
//  PokedexDelegate.swift
//  Pokedex
//
//  The delegate is in charge of loading data using ApiServices
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

protocol PokedexDelegate {
    //An Asynchronous load
    func load(params: [String: Any?]) -> Observable<PokedexModel>
}
