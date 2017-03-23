//
//  DetailsPresenterImpl.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class DetailsPresenterImpl: DetailsPresenter
{
    let disposeBag = DisposeBag()
    let detailsView: DetailsView
    let detailsDelegate: DetailsDelegate
    
    var isLoading = false
    
    // MARK: lifecycle
    init(detailsView: DetailsView,
        detailsDelegate: DetailsDelegate) {
        self.detailsView = detailsView
        self.detailsDelegate = detailsDelegate
    }
    
    // MARK: - main presenter logic
    func load()
    {
        if (!isLoading) {
            isLoading = true
            detailsView.showLoading()
            print("Details loading...")
            detailsDelegate.load(params: ["Some parameter key": "Some parameter value"])
                .subscribe(
                    onNext: { detailsEntity in
                        print("onNext")
                        self.onResponse(detailsEntity)
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
            detailsView.showErrorMessage(ErrorMessage: "Already Loading")
        }
    }
    
    // MARK: - load Event handling
    func onResponse(_ detailsEntity: DetailsEntity) {
        detailsView.displayMessage(Message: "detailsEntity loaded")
        detailsView.navigateToMain()
    }
    
    func onError(_ error: Error) {
        detailsView.hideLoading()
        detailsView.showErrorDialog(ErrorMessage: error.localizedDescription)
    }
    
    func onComplete()
    {
        detailsView.hideLoading()
        isLoading = false
    }
}
