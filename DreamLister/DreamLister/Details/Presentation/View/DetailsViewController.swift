//
//  DetailsViewController.swift
//  DreamLister
//
//  Link your storyboard to this viewController
//
//  Created by Julien Saito on 3/23/17.
//  Copyright (c) 2017 otiasj. All rights reserved.
//


import UIKit

class DetailsViewController: UIViewController, DetailsView, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    let detailsComponent = DetailsComponent()
    // MARK: - Injected
    var detailsPresenter: DetailsPresenter?
    var storePickerAdapter: StorePickerAdapter?

    // MARK: - @IBOutlet
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var selectedItem: Item?
    var imagePicker: UIImagePickerController!
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        detailsComponent.inject(detailsView: self)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePickerAdapter?.setPickerView(pickerView: storePicker)
        
        //createFakeData()
        detailsPresenter?.loadStores()
        
        if let selectedItem = selectedItem {
            displayExistingItem(item: selectedItem)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    // MARK: - @IBOutlet @IBAction
    @IBAction func savePressed(_ sender: Any) {
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        detailsPresenter?.createItem(title: titleField.text,
                                     price: priceField.text,
                                     details: detailsField.text,
                                     store: storePickerAdapter?.getSelectedStore(),
                                     image: picture
                                     )
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if let selectedItem = selectedItem {
            detailsPresenter?.deleteItem(item: selectedItem)
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func displayExistingItem(item: Item) {
        titleField.text = item.title
        priceField.text = "\(item.price)"
        detailsField.text = item.details
        thumbImage.image = item.toImage?.image as? UIImage
        
        if let store = item.toStore, let row = storePickerAdapter?.getRowForStore(store) {
            storePicker.selectRow(row,inComponent: 0,animated: true)
        }
    }
    
    // MARK: - Display logic
    func displayMessage(Message : String) {
        print("Display \(Message)")
    }
    
    func showErrorDialog(ErrorMessage : String) {
        print("Display errort dialog : \(ErrorMessage)")
    }
    
    func showErrorMessage(ErrorMessage : String) {
        print("Show errort message : \(ErrorMessage)")
    }
    
    func navigateToMain() {
        print("Navigating to Main")
        _ = navigationController?.popViewController(animated: true)
    }
    
    func showLoading() {
        print("Something is loading, show the spinner")
    }

    func hideLoading() {
        print("Something finished loading, hide the spinner")
    }
    
    private func createFakeData() {
        let store = Store(context: context)
        store.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "Frys Electronics"
        
        let store3 = Store(context: context)
        store3.name = "Amazon"
        
        let store4 = Store(context: context)
        store4.name = "Tesla Dealership"
        
        let store5 = Store(context: context)
        store5.name = "K Mart"
        
        //appDelegate.saveContext()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
