//
//  VideoPresenter.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

protocol VideoPresenter {
    var VideoView: VideoView? { get set }
    //var delegate:Delegate? { get set }
    
    func load()
}
