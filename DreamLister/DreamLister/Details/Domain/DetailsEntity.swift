//
//  DetailsEntity.swift
//  DreamLister
//
//  This class holds the data loaded from the services
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

class DetailsEntity {
    
    let title: String
    let details: String
    let price: Double
    let toImage: Image
    let store: Store
    
    init(title: String, price: Double, details: String, store: Store, image: Image) {
        self.title = title
        self.details = details
        self.store = store
        self.price = price
        self.toImage = image
    }
}
