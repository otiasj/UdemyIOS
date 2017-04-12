//
//  PokedexView.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
//

protocol PokedexView {
    var pokedexPresenter: PokedexPresenter? { get set }
    
    func displayMessage(message : String)
    func showErrorDialog(errorMessage : String)
    func showErrorMessage(errorMessage : String)
    func showLoading()
    func hideLoading()
}
