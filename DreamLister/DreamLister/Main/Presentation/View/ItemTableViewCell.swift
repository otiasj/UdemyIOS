//
//  ItemCell.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func updateCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as! UIImage?
    }
 }
