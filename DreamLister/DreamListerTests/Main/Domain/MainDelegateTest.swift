//
//  MainDelegateTest.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import RxSwiftTrial

//Testing the presenter interactions with the view and the delegate
class MainDelegateTest: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    //A fake cache service
    class MockMainCacheApiService : MainCacheApiService {
        var loadCallCount = 0
        var storeCallCount = 0
        var clearCallCount = 0
        var mockValue = MainEntity(loadedFrom: "mock cache entity")
        var mockObserver: AnyObserver<MainEntity>?
        
        override func load(withParams: NSDictionary) -> Observable<MainEntity> {
            return Observable.create { observer in
                self.loadCallCount += 1
                self.mockObserver = observer
                return Disposables.create()
            }
        }
        
        func store(_ value: MainEntity, withParams: NSDictionary) {
            storeCallCount += 1
        }
        
        func clear(withParams: NSDictionary) {
            clearCallCount += 1
        }
        
        //trigger a fake value
        func triggerOnNext() {
            if let mockObserver = mockObserver {
                mockObserver.onNext(self.mockValue)
                mockObserver.onCompleted()
            }
        }
        
        func triggerEmptyResult() {
            if let mockObserver = mockObserver {
                mockObserver.onCompleted()
            }
        }
        
        //trigger a fake error
        func triggerOnError() {
            if let mockObserver = mockObserver {
                mockObserver.onError(NSError(domain: "Some error", code: 404))
            }
        }
    }
    
    //A fake network api service
    class MockMainNetworkApiService : MainNetworkApiService {
        var loadCallCount = 0
        var storeCallCount = 0
        var clearCallCount = 0
        var mockValue = MainEntity(loadedFrom: "mock network entity")
        var mockObserver: AnyObserver<MainEntity>?
        
        override func load(withParams: NSDictionary) -> Observable<MainEntity> {
            return Observable.create { observer in
                self.loadCallCount += 1
                self.mockObserver = observer
                return Disposables.create()
            }
        }
        
        func store(_ value: MainEntity, withParams: NSDictionary) {
            storeCallCount += 1
        }
        
        func clear(withParams: NSDictionary) {
            clearCallCount += 1
        }
        
        //trigger a fake value
        func triggerOnNext() {
            if let mockObserver = mockObserver {
                mockObserver.onNext(self.mockValue)
                mockObserver.onCompleted()
            }
        }
        
        //trigger a fake error
        func triggerOnError() {
            if let mockObserver = mockObserver {
                mockObserver.onError(NSError(domain: "Some error", code: 404))
            }
        }
    }
    
    var mockMainDelegate : MainDelegate?
    var mockMainCacheApiService : MockMainCacheApiService?
    var mockMainNetworkApiService : MockMainNetworkApiService?
    
    override func setUp() {
        super.setUp()
        useDefaultSchedulers = true
        mockMainCacheApiService = MockMainCacheApiService()
        mockMainNetworkApiService = MockMainNetworkApiService()
        mockMainDelegate = MainDelegateImpl(mainCacheApiService: mockMainCacheApiService!, mainNetworkApiService: mockMainNetworkApiService!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //check that calling load will receive both an observable from cache and network api servcices
    func testLoadCallsDelegate() {
        let onNextIsCalled = expectation(description: "onNext is called")
        var receivedEntity: MainEntity?
        
        mockMainDelegate!.load(params: [:])
            .subscribe(
                onNext: { entity in
                    XCTAssertNotNil(entity)
                    XCTAssertEqual(entity.getEntityOrigin(), "This Entity was loaded from mock cache entity")
                    receivedEntity = entity
            },
                onError: { error in
                     XCTFail("there should be no error in this test case")
            },
                onCompleted: {
                    onNextIsCalled.fulfill()
            },
                onDisposed: {
                    print("Test Disposed")
            }
            )
            .addDisposableTo(disposeBag)
        
        mockMainCacheApiService?.triggerOnNext() //trigger the cache service response
        mockMainNetworkApiService?.triggerOnNext() //trigger the network service response
        
        self.waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Time out during test!")
            XCTAssertNotNil(receivedEntity)
            XCTAssertEqual(self.mockMainCacheApiService?.loadCallCount, 1)
            XCTAssertEqual(self.mockMainNetworkApiService?.loadCallCount, 0)
        }
        
    }
    
    //check that calling load we receive the result from network
    func testWithNoCache() {
        let onNextIsCalled = expectation(description: "onNext is called")
        var receivedEntity: MainEntity?
        
        mockMainDelegate!.load(params: [:])
            .subscribe(
                onNext: { entity in
                    XCTAssertNotNil(entity)
                    XCTAssertEqual(entity.getEntityOrigin(), "This Entity was loaded from mock network entity")
                    receivedEntity = entity
            },
                onError: { error in
                    XCTFail("there should be no error in this test case")
            },
                onCompleted: {
                    onNextIsCalled.fulfill()
            },
                onDisposed: {
                    print("Test Disposed")
            }
            )
            .addDisposableTo(disposeBag)
        
        mockMainCacheApiService?.triggerEmptyResult() //trigger an empty cache service response
        mockMainNetworkApiService?.triggerOnNext() //trigger the network service response
        
        self.waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Time out during test!")
            XCTAssertNotNil(receivedEntity)
            XCTAssertEqual(self.mockMainCacheApiService?.loadCallCount, 1)
            XCTAssertEqual(self.mockMainNetworkApiService?.loadCallCount, 1)
        }
    }

    //check a cache error is propagated
    func testWithCacheError() {
        let onNextIsCalled = expectation(description: "onError is called")
        
        mockMainDelegate!.load(params: [:])
            .subscribe(
                onNext: { entity in
                    XCTFail("there should be no result in this test case")
            },
                onError: { error in
                    //received error from cache
                    onNextIsCalled.fulfill()
            },
                onCompleted: {
            },
                onDisposed: {
                    print("Test Disposed")
            }
            )
            .addDisposableTo(disposeBag)
        
        mockMainCacheApiService?.triggerOnError()
        mockMainNetworkApiService?.triggerOnNext()
        
        self.waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Time out during test!")
            XCTAssertEqual(self.mockMainCacheApiService?.loadCallCount, 1)
            XCTAssertEqual(self.mockMainNetworkApiService?.loadCallCount, 0)
        }
    }
    
    //check a network error is propagated
    func testWithNetworkError() {
        let onNextIsCalled = expectation(description: "onError is called")
        
        mockMainDelegate!.load(params: [:])
            .subscribe(
                onNext: { entity in
                    XCTFail("there should be no result in this test case")
            },
                onError: { error in
                    //received error from cache
                    onNextIsCalled.fulfill()
            },
                onCompleted: {
            },
                onDisposed: {
                    print("Test Disposed")
            }
            )
            .addDisposableTo(disposeBag)
        
        mockMainCacheApiService?.triggerEmptyResult()
        mockMainNetworkApiService?.triggerOnError()
        
        self.waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Time out during test!")
            XCTAssertEqual(self.mockMainCacheApiService?.loadCallCount, 1)
            XCTAssertEqual(self.mockMainNetworkApiService?.loadCallCount, 1)
        }
    }
}
