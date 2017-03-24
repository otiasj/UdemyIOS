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
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailsComponent.inject(detailsView: self)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }

    // MARK: - @IBOutlet @IBAction
    
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
