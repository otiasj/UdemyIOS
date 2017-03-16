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
    // MARK: - injected fields
    var VideoPresenter: VideoPresenter = VideoPresenterImpl()
    private var _partyRock: PartyRock!
    
    // MARK: - parameters from segue
    var partyRock: PartyRock {
        get {
            return self._partyRock
        } set {
            self._partyRock = newValue
        }
    }
    
    // MARK: - @IBOutlet
    @IBOutlet weak var videoWebview: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        titleLabel.text = partyRock.videoTitle
        videoWebview.loadHTMLString(partyRock.videoUrl, baseURL: nil)
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
