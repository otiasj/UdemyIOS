//
//  ItemTableViewAdapter.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit
import RxSwift

class ItemTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource, OnDataUpdateListener {
    
    var clickListener: ItemCellClickListener?
    var tableView: UITableView?
    var mainEntity: MainEntity?
    
    func setTableView(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell {
            configureCell(cell: cell, indexPath: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let mainEntity = mainEntity {
            return mainEntity.getNumberOfRowsForSection(section)
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let mainEntity = mainEntity {
            return mainEntity.getNumberOfSections()
        } else {
            return 0
        }
    }
    
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     if let clickListener = clickListener {
     let selectedItem = items[indexPath.row]
     clickListener.onItemClicked(item: selectedItem)
     }
     }
     */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func onBeginUpdate() {
        if let tableView = tableView {
            tableView.beginUpdates()
        }
    }
    
    func onEndUpdate() {
        if let tableView = tableView {
            tableView.endUpdates()
        }
    }
    
    func onInsert(indexPath: IndexPath?) {
        if let tableView = tableView {
            tableView.insertRows(at: [indexPath!], with: .fade)
        }
    }
    
    func onDelete(indexPath: IndexPath?) {
        if let tableView = tableView {
            tableView.insertRows(at: [indexPath!], with: .fade)
        }
    }
    
    func onUpdate(indexPath: IndexPath?) {
        if let tableView = tableView, let indexPath = indexPath {
            let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
            configureCell(cell: cell, indexPath: indexPath)
        }
    }
    
    func setMainEntity(_ entity: MainEntity) {
        self.mainEntity = entity
        DispatchQueue.main.async{
            self.tableView?.reloadData()
        }
    }
    
    
    private func configureCell(cell: ItemTableViewCell, indexPath: IndexPath) {
        if let mainEntity = mainEntity {
            let item = mainEntity.getItemAt(indexPath: indexPath)
            cell.updateCell(item: item)
        }
    }
    
}
