//
//  MainPresenterImpl.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainPresenterImpl: MainPresenter
{
    // MARK: lifecycle
    let mainView: MainView
    let partyRockTableAdapter: PartyRockTableAdapter
    
    public init(mainView: MainView, partyRockTableAdapter: PartyRockTableAdapter) {
        self.mainView = mainView
        self.partyRockTableAdapter = partyRockTableAdapter
    }
    
    // MARK: - logic
    
    func load()
    {
        print("Main loading...")
        partyRockTableAdapter.partyRocks = fakeLoad()
        onComplete();
    }
    
    // MARK: - load Event handling
    func onComplete()//(model: MainModel)
    {
        mainView.displayMessage(Message: "Main loaded")
        mainView.navigateToVideo()
    }
    
    private func fakeLoad() -> [PartyRock] {
        var partyRocks = [PartyRock]()
        let partyRock1 = PartyRock(imageUrl: "test1", videoUrl: "1" , videoTitle: "test 1")
        let partyRock2 = PartyRock(imageUrl: "test2", videoUrl: "2" , videoTitle: "test 2")
        let partyRock3 = PartyRock(imageUrl: "test3", videoUrl: "3" , videoTitle: "test 3")
        partyRocks.append(partyRock1)
        partyRocks.append(partyRock2)
        partyRocks.append(partyRock3)
        return partyRocks
    }
}
