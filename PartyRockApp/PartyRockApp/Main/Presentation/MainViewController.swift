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
    let maincomponent = MainComponent()
    //Injected
    var mainPresenter: MainPresenter?
    
    //Injected
    var partyRockTableAdapter: PartyRockTableAdapter?
    
    // MARK: - @IBOutlet
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        maincomponent.inject(mainView: self)
        
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
    
    func navigateToVideo(selectedPartyRock: PartyRock) {
        print("Navigating to Video " + selectedPartyRock.videoTitle)
        performSegue(withIdentifier: "Video", sender: selectedPartyRock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoViewController {
            if let party = sender as? PartyRock {
                destination.partyRock = party   
            }
        }
    }
}
