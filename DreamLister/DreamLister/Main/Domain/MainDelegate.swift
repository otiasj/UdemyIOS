//
//  MainDelegate.swift
//  DreamLister
//
//  The delegate is in charge of loading data using ApiServices
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

protocol MainDelegate {
    //An Asynchronous load
    func load(params: NSDictionary) -> Observable<MainModel>
}
