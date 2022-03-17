//
//  DisplayViewController.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/3/21.
//
//  TODO: - Implement alternative button to present collection view
//

import UIKit

class DisplayViewController: UIViewController, UINavigationControllerDelegate {
    
    var personModel: PersonModelProtocol?
    var displayView: DisplayViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }
    
    func setDisplayView(view: DisplayViewProtocol) {
        displayView = view
        displayView?.setController(controller: self)
    }
    
    func setPersonModel(model: PersonModelProtocol) {
        personModel = model
    }
    
    func setView() {
        let newView = DisplayView(frame: self.view.frame)
        
        setDisplayView(view: newView)
        setDisplayText()
        self.view = displayView as? UIView
    }
    
    func setDisplayText() { 
        if let firstName = personModel?.firstName, let lastName = personModel?.lastName {
            displayView!.displayLabel.text = "\(firstName)\n\(lastName)"
        }
    }
    
    func presentPersonTableVC() {
        let personTableVC = PersonTableViewController()

        present(personTableVC, animated: true, completion: nil)
    }
    
    func returnToRegisterVC() {
        let registerViewController = RegisterViewController()
        
        if let navigationContoller = self.navigationController {
            navigationContoller.popViewController(animated: true)
        }
    }
}
