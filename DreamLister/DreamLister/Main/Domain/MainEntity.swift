//
//  MainEntity.swift
//  DreamLister
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class MainEntity {
    
    //This is just for explaining the purpose of this class
    //Delete this and replace with the variable needed by your feature
    let someValue: String
    
    init(loadedFrom: String) {
        someValue = loadedFrom
    }
    
    init(copy: MainEntity) {
        someValue = copy.someValue
    }
}
