//
//  RegisterViewProtocol.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation

protocol RegisterViewProtocol {
    func setController(controller: RegisterViewController)
    
    func getFirstName() -> String?
    
    func getLastName() -> String?
}
