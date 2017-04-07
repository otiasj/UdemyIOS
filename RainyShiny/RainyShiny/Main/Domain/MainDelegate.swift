//
//  MainDelegate.swift
//  RainyShiny
//
//  The delegate is in charge of loading data using ApiServices
//
//  Created by Julien Saito on 3/25/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

protocol MainDelegate {
    //An Asynchronous load
    func load() -> Observable<MainModel>
    func clearCache()
}
