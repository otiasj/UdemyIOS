//
//  Main.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation

class PartyRock {
    private var _imageUrl: String!
    private var _videoUrl: String!
    private var _videoTitle: String!
    
    init(imageUrl: String, videoUrl: String, videoTitle: String) {
        _imageUrl = imageUrl;
        _videoUrl = videoUrl;
        _videoTitle = videoTitle;
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var videoUrl: String {
        return _videoUrl
    }
    
    var videoTitle: String {
        return _videoTitle
    }
}
