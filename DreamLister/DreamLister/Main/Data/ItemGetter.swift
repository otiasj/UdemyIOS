//
//  ItemGetter.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import CoreData

protocol ItemGetter {
    func item(at indexPath: IndexPath) -> Item
}

/*
class ItemGetter {

    let getter: NSFetchedResultsController<Item>
    
    init(_ getter:NSFetchedResultsController<Item>) {
        self.getter = getter
    }
    
    func object(at indexPath: IndexPath) -> Item {
        return getter.object(at: indexPath)
    }
}
*/

extension NSFetchedResultsController : ItemGetter {
    func item(at indexPath: IndexPath) -> Item {
        return self.object(at: indexPath) as! Item
    }
}

