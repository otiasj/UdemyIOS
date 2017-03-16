//
//  LoginPresenterImpl.swift
//  RxSwiftTrial
//
//  Created by Julien Saito on 3/16/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
import RxSwift

class LoginPresenterImpl: LoginPresenter
{
    var disposeBag = DisposeBag()
    var loginView: LoginView
    var loginDelegate: LoginDelegate
    var backgroundWorkScheduler: ConcurrentDispatchQueueScheduler
    
    // MARK: lifecycle
    public init(loginView: LoginView,
        loginDelegate: LoginDelegate) {
        self.loginView = loginView
        self.loginDelegate = loginDelegate
        backgroundWorkScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    // MARK: - logic
    func load()
    {
        print("Login loading...")
        loginDelegate.load()
            // Subscribe in background thread
            .subscribeOn(backgroundWorkScheduler)
            // Observe in main thread
            .observeOn(MainScheduler())
            // Subscribe on observer
            .subscribe(
                onNext: { loginEntity in
                    print("onNext")
                    self.onResponse(loginEntity)
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
    func onResponse(_ loginEntity: LoginEntity) {
        loginView.displayMessage(Message: "Login loaded")
        loginView.navigateToMain()
    }
    
    func onError(_ error: Error) {
        loginView.showErrorDialog(ErrorMessage: error.localizedDescription)
    }
    
    func onComplete()
    {
    }
}
