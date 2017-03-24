//
//  MainEntity.swift
//  DreamLister
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import CoreData

class MainEntity {
    
    private let sections: [NSFetchedResultsSectionInfo]
    private let itemGetter: ItemGetter
    
    init(sections: [NSFetchedResultsSectionInfo], itemGetter: ItemGetter) {
        self.sections = sections
        self.itemGetter = itemGetter
    }
    
    init(copy: MainEntity) {
        self.sections = copy.sections
        self.itemGetter = copy.itemGetter
    }

    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    func getNumberOfRowsForSection(_ sectionIndex: Int) -> Int {
        let sectionInfo = sections[sectionIndex]
        return sectionInfo.numberOfObjects
    }
    
    func getItemAt(indexPath: IndexPath) -> Item {
        return itemGetter.item(at: indexPath)
    }
    
}
