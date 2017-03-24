//
//  MainPresenterTest.swift
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
class MainPresenterTest: XCTestCase {
    
    class MockMainDelegate : MainDelegate {
        var loadCallCount = 0
        var mockValue = MainModel(from: MainEntity(loadedFrom: "mock value"))
        var mockObserver: AnyObserver<MainModel>?
        
        func load(params: NSDictionary) -> Observable<MainModel> {
            return Observable.create { observer in
                self.loadCallCount += 1
                self.mockObserver = observer
                return Disposables.create()
            }
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
    
    class MockMainView : MainView {
        var mainPresenter: MainPresenter?
        var displayMessageCallCount = 0
        var showErrorDialogCallCount = 0
        var showErrorMessageCallCount = 0
        var navigateToDetailsCallCount = 0
        var showLoadingCallCount = 0
        var hideLoadingCallCount = 0
        
        func displayMessage(Message : String) {
            displayMessageCallCount += 1
        }
        
        func showErrorDialog(ErrorMessage : String) {
            showErrorDialogCallCount += 1
        }
        
        func showErrorMessage(ErrorMessage : String) {
            showErrorMessageCallCount += 1
        }
        
        func navigateToDetails() {
            navigateToDetailsCallCount += 1
        }
        
        func showLoading() {
            showLoadingCallCount += 1
        }
        
        func  hideLoading() {
            hideLoadingCallCount += 1
        }
    }
    
    var mockMainView : MockMainView?
    var mockMainDelegate : MockMainDelegate?
    var mockMainPresenter : MainPresenterImpl?
    
    override func setUp() {
        super.setUp()
        mockMainView = MockMainView()
        mockMainDelegate = MockMainDelegate()
        mockMainPresenter = MainPresenterImpl(mainView: mockMainView!, mainDelegate: mockMainDelegate!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //check that calling load will trigger the delegate successfully
    func testLoadCallsDelegate() {
        mockMainPresenter!.load()
        
        XCTAssert(mockMainDelegate?.loadCallCount == 1)
    }
    
    //Check that calling load with success will generate the proper view calls
    func testLoadSuccess() {
        mockMainPresenter!.load()
      
        //the view shows the loading
        XCTAssert(mockMainView!.showLoadingCallCount == 1)
        XCTAssert(mockMainView!.hideLoadingCallCount == 0)
        
        //Trigger the delegate callback
        mockMainDelegate!.triggerOnNext()
        
        //Verify the results
        XCTAssert(mockMainView!.hideLoadingCallCount == 1)
        XCTAssert(mockMainView!.displayMessageCallCount == 1)
        XCTAssert(mockMainView!.navigateToDetailsCallCount == 1)
        XCTAssert(mockMainView!.showErrorMessageCallCount == 0)
        XCTAssert(mockMainView!.showErrorDialogCallCount == 0)
    }
    
    //Check that calling load with an error will generate the proper view error calls
    func testLoadError() {
        mockMainPresenter!.load()
        
        //the view shows the loading
        XCTAssert(mockMainView!.showLoadingCallCount == 1)
        XCTAssert(mockMainView!.hideLoadingCallCount == 0)
        
        //Trigger the delegate callback
        mockMainDelegate!.triggerOnError()
        
        //Verify the results
        XCTAssert(mockMainView!.hideLoadingCallCount == 1)
        XCTAssert(mockMainView!.displayMessageCallCount == 0)
        XCTAssert(mockMainView!.navigateToDetailsCallCount == 0)
        XCTAssert(mockMainView!.showErrorMessageCallCount == 0)
        XCTAssert(mockMainView!.showErrorDialogCallCount == 1)

    }
    
    //Check that calling load twice will not trigger several loading calls
    func testLoadAlreadyLoadingError() {
        mockMainPresenter!.load()
        mockMainPresenter!.load()
        
        //the view shows the loading
        XCTAssert(mockMainView!.showLoadingCallCount == 1)
        XCTAssert(mockMainView!.hideLoadingCallCount == 0)
        XCTAssert(mockMainView!.showErrorMessageCallCount == 1)
        
        //Trigger the delegate callback
        mockMainDelegate!.triggerOnNext()
        
        //Verify the results
        XCTAssert(mockMainView!.hideLoadingCallCount == 1)
        XCTAssert(mockMainView!.displayMessageCallCount == 1)
        XCTAssert(mockMainView!.navigateToDetailsCallCount == 1)
        XCTAssert(mockMainView!.showErrorMessageCallCount == 1)
        XCTAssert(mockMainView!.showErrorDialogCallCount == 0)
    }
    
}
