//
//  RxSwiftTest.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/21/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import RxSwiftTrial

//Testing the presenter interactions with the view and the delegate
class RxSwiftTest: XCTestCase {
    
    let disposeBag = DisposeBag()

    func testConcat() {
        
        let myObservable1 = Observable.from(["event1", "event2", "event3"])
        let myObservable2 = Observable.from(["eventA", "eventB", "eventC"])
        
        Observable<String>.concat([myObservable1, myObservable2])
            .map { value in return value.characters.count }
            .subscribe(
                onNext: { nextValue in
                    print("onNext \(nextValue)")
            },
                onError: { error in
                    print("some error")
            },
                onCompleted: {
                    print("onComplete")
            },
                onDisposed: {
                    print("Test Disposed")
            }).dispose()
        
//        Observable<HomeSettingsEntity>
//            .concat([cacheObservable, networkObservable]) // try first on cache, then network
//            .take(1) // take the first non empty event (first does not exist in rxswift?!)
//            .map { entity in return HomeSettingsModel(from: entity) } // create a Model wrapping the received entity
//            .composeIoToMainThreads() // send the work in a background thread and post the results in the UI thread
//            .subscribe(subject!.asObserver()) // will report the results to the replay subject observer
//            .addDisposableTo(disposeBag) // clean up after execution

    }
}
