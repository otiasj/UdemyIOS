//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
        
    }
}
