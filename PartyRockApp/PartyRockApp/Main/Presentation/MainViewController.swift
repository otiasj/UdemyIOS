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
    var mainPresenter: MainPresenter
    var partyRockTableAdapter: PartyRockTableAdapter
    
    // MARL: - Dependency creation
    convenience init() {
        self.init()
        let maincomponent = MainComponent(mainView: self);
        maincomponent.inject(mainViewToInject: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - @IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainTableView.delegate = partyRockTableAdapter
        mainTableView.dataSource = partyRockTableAdapter
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
