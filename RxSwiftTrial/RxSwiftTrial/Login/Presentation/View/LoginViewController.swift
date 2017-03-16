//
//  LoginViewController.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/16/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController, LoginView
{
    
    let loginComponent = LoginComponent()
    // MARK: - Injected
    var loginPresenter: LoginPresenter?

    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loginComponent.inject(loginView: self)
        
        titleLabel.text = "Login"
        loadButton.setTitle("Navigate to Main", for: .normal)
    }
    
    // MARK: - @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    
    // MARK: - @IBOutlet @IBAction
    @IBAction func onLoadClick(_ sender: Any) {
        if let loginPresenter = loginPresenter {
            loginPresenter.load()
        }
    }
    
    // MARK: - Display logic
    func displayMessage(Message : String) {
        print("Display \(Message)")
        titleLabel.text = Message
    }
    
    func showErrorDialog(ErrorMessage : String) {
        print("Display errort dialog : \(ErrorMessage)")
        titleLabel.text = ErrorMessage
    }
    
    func showErrorMessage(ErrorMessage : String) {
        print("Show errort message : \(ErrorMessage)")
        titleLabel.text = ErrorMessage
    }
    
    func navigateToMain() {
        print("Navigating to Main")
        performSegue(withIdentifier: "Main", sender: self)
    }

}
