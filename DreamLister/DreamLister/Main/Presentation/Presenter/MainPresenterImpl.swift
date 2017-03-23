//
//  MainPresenterImpl.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainPresenterImpl: MainPresenter
{
    let disposeBag = DisposeBag()
    let mainView: MainView
    let mainDelegate: MainDelegate
    let itemTableViewAdapter: ItemTableViewAdapter
    var isLoading = false
    
    // MARK: lifecycle
    init(mainView: MainView,
        mainDelegate: MainDelegate,
        itemTableViewAdapter: ItemTableViewAdapter) {
        self.mainView = mainView
        self.mainDelegate = mainDelegate
        self.itemTableViewAdapter = itemTableViewAdapter
    }
    
    // MARK: - main presenter logic
    func load()
    {
        if (!isLoading) {
            isLoading = true
            mainView.showLoading()
            print("Main loading...")
            mainDelegate.load(params: ["Some parameter key": "Some parameter value"])
                .subscribe(
                    onNext: { mainEntity in
                        print("onNext")
                        self.onResponse(mainEntity)
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
        } else {
            mainView.showErrorMessage(ErrorMessage: "Already Loading")
        }
    }
    
    // MARK: - load Event handling
    func onResponse(_ mainEntity: MainEntity) {
        mainView.displayMessage(Message: "mainEntity loaded")
        mainView.navigateToDetails()
    }
    
    func onError(_ error: Error) {
        mainView.hideLoading()
        mainView.showErrorDialog(ErrorMessage: error.localizedDescription)
    }
    
    func onComplete()
    {
        mainView.hideLoading()
        isLoading = false
    }
}
