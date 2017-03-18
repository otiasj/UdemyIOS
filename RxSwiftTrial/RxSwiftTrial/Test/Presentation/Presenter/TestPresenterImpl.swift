//
//  TestPresenterImpl.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/17/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class TestPresenterImpl: TestPresenter
{
    let disposeBag = DisposeBag()
    var testView: TestView
    var testDelegate: TestDelegate
    
    // MARK: lifecycle
    init(testView: TestView,
        testDelegate: TestDelegate) {
        self.testView = testView
        self.testDelegate = testDelegate
    }
    
    // MARK: - logic
    func load()
    {
        print("Test loading...")
        testDelegate.load(params: ["Some parameter key": "Some parameter value"])
            .subscribe(
                onNext: { testModel in
                    print("onNext")
                    self.onResponse(testModel)
            },
                onError: { error in
                    print(error)
                    self.onError(error)
            },
                onCompleted: {
                    print("Completed")
                    self.onComplete()
            },
                onDisposed: {
                    print("Disposed")
            }
            )
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - load Event handling
    func onResponse(_ testModel: TestModel) {
        testView.displayMessage(Message: "testModel: \(testModel.getEntityOrigin())")
        testView.navigateToLogin()
    }
    
    func onError(_ error: Error) {
        testView.showErrorDialog(ErrorMessage: error.localizedDescription)
    }
    
    func onComplete()
    {
    }
}
