//
//  PersonTableViewProtocol.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 1/29/22.
//

import Foundation
import UIKit

protocol PersonTableViewProtocol {
    var tableView: UITableView {get}
    
    func setController(controller: PersonTableViewController) 
}
