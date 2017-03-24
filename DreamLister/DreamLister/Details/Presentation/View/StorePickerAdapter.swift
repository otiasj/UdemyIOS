//
//  StorePickerAdapter.swift
//  DreamLister
//
//  Created by Julien Saito on 3/23/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class StorePickerAdapter: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var stores = [Store]()
    var pickerView: UIPickerView?
    
    func setPickerView(pickerView: UIPickerView) {
        self.pickerView = pickerView
        self.pickerView?.delegate = self
        self.pickerView?.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    //columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func setStores(stores:[Store]) {
        self.stores = stores
        if let pickerView = pickerView {
            pickerView.reloadAllComponents()
        }
    }
    
    func getSelectedStore() -> Store {
        return stores[(pickerView?.selectedRow(inComponent: 0))!]
    }
    
    func getRowForStore(_ storeToFind: Store) -> Int {
        var index = 0
        for store in stores {
            if (storeToFind == store) {
                return index
            } else {
                index += 1
            }
        }
        return 0
    }
}
