//
//  MainPresenterImpl.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainPresenterImpl: MainPresenter
{
    var mainView: MainView?
    
    // MARK: lifecycle
    public init() {
    }
    
    // FIXME: Add some initialization / clean up
    
    // MARK: - logic
    
    func load()
    {
        print("Main loading...")
        //delegate.load()
        onComplete();
    }
    
    // MARK: - load Event handling
    
    func onComplete()//(model: MainModel)
    {
        if let mainView = mainView {
            mainView.displayMessage(Message: "Main loaded")
            mainView.navigateTomain()
        }
    }
}
