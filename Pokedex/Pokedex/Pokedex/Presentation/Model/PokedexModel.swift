//
//  PokedexModel.swift
//  Pokedex
//
//  This class wraps the data loaded from the services, and provides presentation related data manipulation.
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation

class PokedexModel : PokedexEntity {

    init(from : PokedexEntity) {
        super.init(copy: from)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encode(with coder: NSCoder) {
        super.encode(with: coder)
    }
    
    // FIXME This is a function to demonstrate what type of data manipulation we are expecting to happen in this class
    // This should be deleted and adapted according to your feature needs.
    func getEntityOrigin() -> String {
        return "This Entity was loaded from \(super.someValue)"
    }
}
