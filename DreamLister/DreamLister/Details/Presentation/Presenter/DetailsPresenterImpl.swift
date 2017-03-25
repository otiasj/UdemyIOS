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
    let storePickerAdapter: StorePickerAdapter
    
    var isLoading = false
    
    // MARK: lifecycle
    init(detailsView: DetailsView,
        detailsDelegate: DetailsDelegate,
        storePickerAdapter: StorePickerAdapter) {
        self.detailsView = detailsView
        self.detailsDelegate = detailsDelegate
        self.storePickerAdapter = storePickerAdapter
    }
    
    // MARK: - presenter logic
    func loadStores()
    {
        if (!isLoading) {
            isLoading = true
            detailsView.showLoading()
            print("Details loading...")
            detailsDelegate.load()
                .subscribe(
                    onNext: { stores in
                        print("onNext")
                        self.onResponse(stores)
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
    
    func createItem(title: String?,
                    price: String?,
                    details: String?,
                    store: Store?,
                    image: Image?) {
        if let title = title,
            !title.isEmpty,
            let price = price,
            !price.isEmpty,
            let details = details,
            !details.isEmpty,
            let image = image,
            let store = store {
            let item = DetailsEntity(title: title, price: (price as NSString).doubleValue, details: details, store: store, image: image)
            detailsDelegate.save(item)
            detailsView.navigateToMain()
        } else {
            detailsView.showErrorMessage(ErrorMessage: "Missing values")
        }
    }
    
    func deleteItem(item: Item) {
        detailsDelegate.delete(item)
        detailsView.navigateToMain()
    }
    
    // MARK: - load Event handling
    func onResponse(_ stores: [Store]) {
        storePickerAdapter.setStores(stores: stores)
        detailsView.displayMessage(Message: "detailsEntity loaded")
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
