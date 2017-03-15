//
//  VideoViewController.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class VideoViewController: UIViewController, VideoView
{
    var VideoPresenter: VideoPresenter = VideoPresenterImpl()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: - @IBOutlet
    
    
    // MARK: - @IBOutlet @IBAction
    @IBAction func onLoadClick(_ sender: Any) {
        VideoPresenter.load()
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
    
    func navigateBack() {
        print("Navigating Back")
        dismiss(animated: true, completion: nil)
    }
}
