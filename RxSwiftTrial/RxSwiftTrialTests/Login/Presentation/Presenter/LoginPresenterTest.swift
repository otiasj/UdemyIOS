//
//  LoginPresenterTest.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/20/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import RxSwiftTrial

//Testing the presenter interactions with the view and the delegate
class LoginPresenterTest: XCTestCase {
    
    class MockLoginDelegate : LoginDelegate {
        var loadCallCount = 0
        var mockValue = LoginModel(from: LoginEntity(loadedFrom: "mock value"))
        var mockObserver: AnyObserver<LoginModel>?
        
        func load(params: NSDictionary) -> Observable<LoginModel> {
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
    
    class MockLoginView : LoginView {
        var loginPresenter: LoginPresenter?
        var displayMessageCallCount = 0
        var showErrorDialogCallCount = 0
        var showErrorMessageCallCount = 0
        var navigateTo___VARIABLE_SegueTargetName___CallCount = 0
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
        
        func navigateTo___VARIABLE_SegueTargetName___() {
            navigateTo___VARIABLE_SegueTargetName___CallCount += 1
        }
        
        func showLoading() {
            showLoadingCallCount += 1
        }
        
        func  hideLoading() {
            hideLoadingCallCount += 1
        }
    }
    
    var mockLoginView : MockLoginView?
    var mockLoginDelegate : MockLoginDelegate?
    var mockLoginPresenter : LoginPresenterImpl?
    
    override func setUp() {
        super.setUp()
        mockLoginView = MockLoginView()
        mockLoginDelegate = MockLoginDelegate()
        mockLoginPresenter = LoginPresenterImpl(loginView: mockLoginView!, loginDelegate: mockLoginDelegate!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //check that calling load will trigger the delegate successfully
    func testLoadCallsDelegate() {
        mockLoginPresenter!.load()
        
        XCTAssert(mockLoginDelegate?.loadCallCount == 1)
    }
    
    //Check that calling load with success will generate the proper view calls
    func testLoadSuccess() {
        mockLoginPresenter!.load()
      
        //the view shows the loading
        XCTAssert(mockLoginView!.showLoadingCallCount == 1)
        XCTAssert(mockLoginView!.hideLoadingCallCount == 0)
        
        //Trigger the delegate callback
        mockLoginDelegate!.triggerOnNext()
        
        //Verify the results
        XCTAssert(mockLoginView!.hideLoadingCallCount == 1)
        XCTAssert(mockLoginView!.displayMessageCallCount == 1)
        XCTAssert(mockLoginView!.navigateTo___VARIABLE_SegueTargetName___CallCount == 1)
        XCTAssert(mockLoginView!.showErrorMessageCallCount == 0)
        XCTAssert(mockLoginView!.showErrorDialogCallCount == 0)
    }
    
    //Check that calling load with an error will generate the proper view error calls
    func testLoadError() {
        mockLoginPresenter!.load()
        
        //the view shows the loading
        XCTAssert(mockLoginView!.showLoadingCallCount == 1)
        XCTAssert(mockLoginView!.hideLoadingCallCount == 0)
        
        //Trigger the delegate callback
        mockLoginDelegate!.triggerOnError()
        
        //Verify the results
        XCTAssert(mockLoginView!.hideLoadingCallCount == 1)
        XCTAssert(mockLoginView!.displayMessageCallCount == 0)
        XCTAssert(mockLoginView!.navigateTo___VARIABLE_SegueTargetName___CallCount == 0)
        XCTAssert(mockLoginView!.showErrorMessageCallCount == 0)
        XCTAssert(mockLoginView!.showErrorDialogCallCount == 1)

    }
    
    //Check that calling load twice will not trigger several loading calls
    func testLoadAlreadyLoadingError() {
        mockLoginPresenter!.load()
        mockLoginPresenter!.load()
        
        //the view shows the loading
        XCTAssert(mockLoginView!.showLoadingCallCount == 1)
        XCTAssert(mockLoginView!.hideLoadingCallCount == 0)
        XCTAssert(mockLoginView!.showErrorMessageCallCount == 1)
        
        //Trigger the delegate callback
        mockLoginDelegate!.triggerOnNext()
        
        //Verify the results
        XCTAssert(mockLoginView!.hideLoadingCallCount == 1)
        XCTAssert(mockLoginView!.displayMessageCallCount == 1)
        XCTAssert(mockLoginView!.navigateTo___VARIABLE_SegueTargetName___CallCount == 1)
        XCTAssert(mockLoginView!.showErrorMessageCallCount == 1)
        XCTAssert(mockLoginView!.showErrorDialogCallCount == 0)
    }
    
}
