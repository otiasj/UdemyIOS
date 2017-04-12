//
//  PokedexPresenterImpl.swift
//  Pokedex
//
//  Created by Julien Saito on 4/12/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//

import RxSwift

class PokedexPresenterImpl: PokedexPresenter
{
    let disposeBag = DisposeBag()
    let pokedexView: PokedexView
    let pokedexDelegate: PokedexDelegate
    
    var isLoading = false
    
    // MARK: lifecycle
    init(pokedexView: PokedexView,
        pokedexDelegate: PokedexDelegate) {
        self.pokedexView = pokedexView
        self.pokedexDelegate = pokedexDelegate
    }
    
    // MARK: - main presenter logic
    func load()
    {
        if (!isLoading) {
            isLoading = true
            pokedexView.showLoading()
            print("Pokedex loading...")
            pokedexDelegate.load(params: ["Some parameter key": "Some parameter value"])
                .subscribe(
                    onNext: { pokedexEntity in
                        print("onNext")
                        self.onResponse(pokedexEntity)
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
            pokedexView.showErrorMessage(errorMessage: "Already Loading")
        }
    }
    
    // MARK: - load Event handling
    func onResponse(_ pokedexEntity: PokedexEntity) {
        pokedexView.displayMessage(message: "pokedexEntity loaded")
    }
    
    func onError(_ error: Error) {
        pokedexView.hideLoading()
        pokedexView.showErrorDialog(errorMessage: error.localizedDescription)
        isLoading = false
    }
    
    func onComplete()
    {
        pokedexView.hideLoading()
        isLoading = false
    }
}
