//
//  DetailsModel.swift
//  DreamLister
//
//  This class wraps the data loaded from the services, and provides presentation related data manipulation.
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class DetailsModel : DetailsEntity {

    init(from : DetailsEntity) {
        super.init(copy: from)
    }
    
    // FIXME This is a function to demonstrate what type of data manipulation we are expecting to happen in this class
    // This should be deleted and adapted according to your feature needs.
    func getEntityOrigin() -> String {
        return "This Entity was loaded from \(super.someValue)"
    }
}
