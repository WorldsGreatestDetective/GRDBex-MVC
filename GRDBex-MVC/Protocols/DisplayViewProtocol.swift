//
//  DisplayViewProtocol.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/3/21.
//

import Foundation
import UIKit

protocol DisplayViewProtocol {
    var displayLabel: UILabel {get}
    
    func setController(controller: DisplayViewController)
}
