//
//  ItemTableViewAdapter.swift
//  DreamLister
//
//  Created by Julien Saito on 3/22/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit

class ItemTableViewAdapter: NSObject, UITableViewDelegate, UITableViewDataSource, OnDataUpdateListener {
    
    var items = [Item]()
    var clickListener: ItemCellClickListener?
    var tableView: UITableView?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell {
            let item = items[indexPath.row]
            cell.updateCell(item: item)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let clickListener = clickListener {
            let selectedItem = items[indexPath.row]
            clickListener.onItemClicked(item: selectedItem)
        }
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
        if let tableView = tableView {
            let cell = tableView.cellForRow(at: indexPath!) as! ItemTableViewCell
            //FIXME update cell
        }
    }
    
}
