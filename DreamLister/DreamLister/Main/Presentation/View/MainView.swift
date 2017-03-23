//
//  MainView.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
//

protocol MainView {
    var mainPresenter: MainPresenter? { get set }
    
    func displayMessage(Message : String)
    func showErrorDialog(ErrorMessage : String)
    func showErrorMessage(ErrorMessage : String)
    func navigateToDetails()
    func showLoading()
    func hideLoading()
}
