//
//  MainView.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
//

protocol MainView {
    //the instances to inject
    var mainPresenter: MainPresenter? { get set }
    var partyRockTableAdapter: PartyRockTableAdapter? { get set }
    
    func displayMessage(Message : String)
    func showErrorDialog(ErrorMessage : String)
    func showErrorMessage(ErrorMessage : String)
    func navigateToVideo(selectedPartyRock : PartyRock)
    
}
