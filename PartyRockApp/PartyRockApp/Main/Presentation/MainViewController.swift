//
//  MainViewController.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class MainViewController: UIViewController, MainView
{
    var mainPresenter: MainPresenter = MainPresenterImpl()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        titleLabel.text = "Main"
        loadButton.setTitle("Navigate to main", for: .normal)
    }
    
    // MARK: - @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - @IBOutlet @IBAction
    @IBAction func onLoadClick(_ sender: Any) {
        mainPresenter.load()
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
    
    func navigateToVideo() {
        print("Navigating to Video")
        performSegue(withIdentifier: "Video", sender: self)
        
    }
}
