//
//  MainPresenterImpl.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class MainPresenterImpl: MainPresenter, ItemCellClickListener
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
        self.itemTableViewAdapter.clickListener = self
        //createFakeData()
    }
    
    func onItemClicked(item: Item) {
        mainView.navigateToDetails(of: item)
    }
    
    // MARK: - main presenter logic
    func load(sortBy: Int)
    {
        if (!isLoading) {
            
            var sortByAsEnum = SortBy.date
            if sortBy == 1 {
                sortByAsEnum = SortBy.price
            } else if sortBy == 2 {
                sortByAsEnum = SortBy.title
            }
            
            isLoading = true
            mainView.showLoading()
            mainDelegate.load(sortBy: sortByAsEnum)
                .composeIoToMainThreads()
                .subscribe(
                    onNext: { mainEntity in
                        self.onResponse(mainEntity)
                },
                    onError: { error in
                        self.onError(error)
                },
                    onCompleted: {
                        self.onComplete()
                },
                    onDisposed: {}
                )
                .addDisposableTo(disposeBag)
        } else {
            mainView.showErrorMessage(ErrorMessage: "Already Loading")
        }
    }
    
    func createFakeData() {
        let item = Item(context: context)
        item.title = "item 1"
        item.price = 1800
        item.details = "some details about item 1"
        
        let item2 = Item(context: context)
        item2.title = "item 2"
        item2.price = 100
        item2.details = "some details about item 2"
        
        let item3 = Item(context: context)
        item3.title = "item 3"
        item3.price = 11
        item3.details = "some details about item 3"
        
        let item4 = Item(context: context)
        item4.title = "item 4"
        item4.price = 57
        item4.details = "some details about item 4"
        
        //appDelegate.saveContext()
    }
    
    // MARK: - load Event handling
    func onResponse(_ mainEntity: MainEntity) {
        mainView.displayMessage(Message: "mainEntity loaded")
        itemTableViewAdapter.setMainEntity(mainEntity)
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
