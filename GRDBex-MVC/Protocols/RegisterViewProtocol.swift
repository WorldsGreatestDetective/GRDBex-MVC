//
//  RegisterViewProtocol.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation
import UIKit

protocol RegisterViewProtocol {
    var firstNameField: UITextField {get}
    
    var lastNameField: UITextField {get}
    
    func setController(controller: RegisterViewController)
    
    func getFirstName() -> String?
    
    func getLastName() -> String?
}
