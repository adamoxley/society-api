//
//  TableViewCompatible.swift
//  Society
//
//  Created by Adam Oxley on 15/11/2019.
//  Copyright © 2019 Adam Oxley. All rights reserved.
//

import UIKit

protocol TableViewCompatible {
    
    var identifier: String { get }
    
    func cellForTableView(tableView: UITableView, atIndexPath: IndexPath) -> UITableViewCell 
}
