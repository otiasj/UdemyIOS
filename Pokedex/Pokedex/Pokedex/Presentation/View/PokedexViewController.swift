//
//  PokedexViewController.swift
//  Pokedex
//
//  Link your storyboard to this viewController
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class PokedexViewController: UIViewController, PokedexView
{
    
    let pokedexComponent = PokedexComponent()
    // MARK: - Injected
    var pokedexPresenter: PokedexPresenter?

    // MARK: - @IBOutlet
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pokedexComponent.inject(pokedexView: self)
        
    }

    // MARK: - @IBOutlet @IBAction

    
    // MARK: - Display logic
    func displayMessage(message : String) {
        showDialog(title: "Success!", message: message)
    }
    
    func showErrorDialog(errorMessage : String) {
        showDialog(title: "Error", message: errorMessage)
    }
    
    func showErrorMessage(errorMessage : String) {
        showToast(message: errorMessage)
    }
    
    func showLoading() {
        print("Something is loading, show the spinner")
    }

    func hideLoading() {
        print("Something finished loading, hide the spinner")
    }
}
