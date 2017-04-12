//
//  PokedexEntity.swift
//  Pokedex
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import Foundation

class PokedexEntity: NSObject, NSCoding {
    
    //This is just for explaining the purpose of this class
    //Delete this and replace with the variable needed by your feature
    let someValue: String
    
    init(loadedFrom: String) {
        someValue = loadedFrom
    }
    
    init(copy: PokedexEntity) {
        someValue = copy.someValue
    }
    
    //restore a PokedexEntity from preferences
    required init?(coder aDecoder: NSCoder) {
        someValue = aDecoder.decodeObject(forKey: "someValue") as! String
    }
    
    //save a PokedexEntity to preferences
    func encode(with coder: NSCoder) {
        coder.encode(someValue, forKey: "someValue")
    }
}
