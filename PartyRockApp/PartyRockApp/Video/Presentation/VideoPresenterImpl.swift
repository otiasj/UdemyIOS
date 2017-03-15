//
//  VideoPresenterImpl.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class VideoPresenterImpl: VideoPresenter
{
    var VideoView: VideoView?
    
    // MARK: lifecycle
    public init() {
    }
    
    // FIXME: Add some initialization / clean up
    
    // MARK: - logic
    
    func load()
    {
        print("Video loading...")
        //delegate.load()
        onComplete();
    }
    
    // MARK: - load Event handling
    
    func onComplete()//(model: VideoModel)
    {
        if let VideoView = VideoView {
            VideoView.displayMessage(Message: "Video loaded")
            VideoView.navigateToBack()
        }
    }
}
