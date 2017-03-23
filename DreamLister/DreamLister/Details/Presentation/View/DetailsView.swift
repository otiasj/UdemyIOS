//
//  DetailsView.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//
//

protocol DetailsView {
    var detailsPresenter: DetailsPresenter? { get set }
    
    func displayMessage(Message : String)
    func showErrorDialog(ErrorMessage : String)
    func showErrorMessage(ErrorMessage : String)
    func navigateToMain()
    func showLoading()
    func hideLoading()
}
