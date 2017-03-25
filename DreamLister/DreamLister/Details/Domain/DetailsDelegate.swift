//
//  DetailsDelegate.swift
//  DreamLister
//
//  The delegate is in charge of loading data using ApiServices
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

protocol DetailsDelegate {
    //An Asynchronous load
    func load() -> Observable<[Store]>
    func save(_ detailEntity: DetailsEntity)
    func delete(_ item: Item)
}
