//
//  TestDelegate.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/17/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

protocol TestDelegate {
    //An Asynchronous load
    func load(params: NSDictionary) -> Observable<TestModel>
}
