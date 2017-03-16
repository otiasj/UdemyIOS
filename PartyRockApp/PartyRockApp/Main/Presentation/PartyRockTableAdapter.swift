//
//  MainTableAdapter.swift
//  PartyRockApp
//
//  Created by Julien Saito on 3/15/17.
//  Copyright © 2017 otiasj. All rights reserved.
//

import UIKit
import Foundation


class PartyRockTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var partyRocks = [PartyRock]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyRockTableViewCell", for: indexPath) as? PartyRockTableViewCell {
            let partyRock = partyRocks[indexPath.row]
            cell.updateCell(partyRock: partyRock)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRocks.count
    }
}
