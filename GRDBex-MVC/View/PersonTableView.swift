//
//  PersonTableView.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 1/29/22.
//

import UIKit

class PersonTableView: UIView, PersonTableViewProtocol {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    var controller: PersonTableViewController?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .white
        
        addSubview(tableView)
    }
    
    func setController(controller: PersonTableViewController) {
        self.controller = controller
    }
    
}
