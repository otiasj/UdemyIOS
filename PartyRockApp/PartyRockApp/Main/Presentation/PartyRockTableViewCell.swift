//
//  PartyCellTableViewCell.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class PartyRockTableViewCell: UITableViewCell {

    @IBOutlet weak var videoPreviewImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!

    func updateCell(partyRock: PartyRock) {
        videoTitle.text = partyRock.videoTitle
//        videoPreviewImage.image = partyRock.imageUrl
    }
}
