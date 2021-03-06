//
//  DetailsPresenter.swift
//  DreamLister
//
//  This class holds the logic of the Details feature.
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

protocol DetailsPresenter {
    func loadStores()
    func createItem(title: String?, price: String?, details: String?, store: Store?, image: Image?)
    func deleteItem(item: Item)
}
