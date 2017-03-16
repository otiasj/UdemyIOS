//
//  MainPresenterImpl.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainPresenterImpl: MainPresenter, ClickListener
{
    // MARK: lifecycle
    let mainView: MainView
    let partyRockTableAdapter: PartyRockTableAdapter
    
    public init(mainView: MainView, partyRockTableAdapter: PartyRockTableAdapter) {
        self.mainView = mainView
        self.partyRockTableAdapter = partyRockTableAdapter
        load()
        self.partyRockTableAdapter.clickListener = self
    }
    
    // MARK: - logic
    
    func load()
    {
        print("Main loading...")
        partyRockTableAdapter.partyRocks = fakeLoad()
    }
    
    func onVideoSelected(partyRock: PartyRock) {
        mainView.navigateToVideo(selectedPartyRock: partyRock)
    }
    
    private func fakeLoad() -> [PartyRock] {
        var partyRocks = [PartyRock]()
        let partyRock1 = PartyRock(imageUrl: "http://www.wavefm.com.au/images/stories/2015/04/redfoo.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ev4bY1SkZLg\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Lights Out")
        
        let partyRock2 = PartyRock(imageUrl: "http://www.croshalgroup.com/wp-content/uploads/2015/05/Redfoo-Website.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/1w9DiGlZksU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Let's Get Ridiculous")
        let partyRock3 = PartyRock(imageUrl: "https://i.ytimg.com/vi/2wUxw6GH3IM/hqdefault.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/vg_nvEGryA4\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Juicy Wiggle Lesson")
        let partyRock4 = PartyRock(imageUrl: "http://www.billboard.com/files/styles/article_main_image/public/media/lmfao-party-rock-anthem-2011-billboard-650.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gZIqW92GaTQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Party Rock Commercial")
        let partyRock5 = PartyRock(imageUrl: "http://direct-ns.rhap.com/imageserver/v2/albums/Alb.219913217/images/600x600.jpg", videoUrl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/tWyuglGCKgE\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Juicy Wiggle")

        partyRocks.append(partyRock1)
        partyRocks.append(partyRock2)
        partyRocks.append(partyRock3)
        partyRocks.append(partyRock4)
        partyRocks.append(partyRock5)
        return partyRocks
    }
}
