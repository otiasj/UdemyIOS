//
//  MainViewController.swift
//  DreamLister
//
//  Link your storyboard to this viewController
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class MainViewController: UIViewController, MainView
{
    let mainComponent = MainComponent()
    // MARK: - Injected
    var mainPresenter: MainPresenter?
    var itemTableViewAdapter: ItemTableViewAdapter?

    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainComponent.inject(mainView: self)
        itemTableViewAdapter?.setTableView(tableView: tableView)
        mainPresenter?.load(sortBy: 0)
    }
    
    @IBAction func onSort(_ sender: Any) {
        if let index = segment.selectedSegmentIndex as Int? {
            mainPresenter?.load(sortBy: index)
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
    
    func navigateToDetails() {
        print("Navigating to Details")
        performSegue(withIdentifier: "Details", sender: self)
    }
    
    func navigateToDetails(of: Item) {
        print("Navigating to Details of \(of.title)")
        performSegue(withIdentifier: "Details", sender: of)
    }
    
    func showLoading() {
        print("Something is loading, show the spinner")
    }

    func hideLoading() {
        print("Something finished loading, hide the spinner")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details", let destination = segue.destination as? DetailsViewController {
            if let item = sender as? Item {
                destination.selectedItem = item
            }
        }
    }
}
