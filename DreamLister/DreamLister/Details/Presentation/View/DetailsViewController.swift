//
//  DetailsViewController.swift
//  DreamLister
//
//  Link your storyboard to this viewController
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController, DetailsView
{
    
    let detailsComponent = DetailsComponent()
    // MARK: - Injected
    var detailsPresenter: DetailsPresenter?

    // MARK: - @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailsComponent.inject(detailsView: self)
        
        titleLabel.text = "Details"
        loadButton.setTitle("Navigate to Main", for: .normal)
    }

    // MARK: - @IBOutlet @IBAction
    @IBAction func onLoadClick(_ sender: Any) {
        if let detailsPresenter = detailsPresenter {
            detailsPresenter.load()
        }
    }
    
    // MARK: - Display logic
    func displayMessage(Message : String) {
        print("Display \(Message)")
    }
    
    func showErrorDialog(ErrorMessage : String) {
        print("Display errort dialog : \(ErrorMessage)")
    }
    
    func showErrorMessage(ErrorMessage : String) {
        print("Show errort message : \(ErrorMessage)")
    }
    
    func navigateToMain() {
        print("Navigating to Main")
        performSegue(withIdentifier: "Main", sender: self)
        
    }
    
    func showLoading() {
        print("Something is loading, show the spinner")
    }

    func hideLoading() {
        print("Something finished loading, hide the spinner")
    }
}
