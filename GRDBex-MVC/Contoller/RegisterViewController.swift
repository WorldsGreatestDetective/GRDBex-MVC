//
//  RegisterViewController.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//
//  TODO: Make sure user cannot enter empty name; present alert
//

import UIKit

class RegisterViewController: UIViewController {
    
    var personModel: PersonModelProtocol?
    var registerView: RegisterViewProtocol?
    
    let networkManager = NetworkManager(httpMethod: .GET)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        remoteSync()
    }
    
    func setRegisterView(view: RegisterViewProtocol) {
        registerView = view
        registerView?.setController(controller: self)
    }
    
    func setPersonModel(model: PersonModelProtocol) {
        personModel = model
    }
    
    func setView() {
        let newView = RegisterView(frame: self.view.frame)
        
        setRegisterView(view: newView)
        self.view = registerView as? UIView
    }
    
    func registerPerson() {
        let firstNameText = registerView?.getFirstName()
        let lastNameText = registerView?.getLastName()
        
        if let firstName = firstNameText, let lastName = lastNameText {
            let person = Person(id: Person.setid(), firstName: firstName, lastName: lastName)
            
            setPersonModel(model: person)
            Person.persistNewPerson(person: personModel!)
        }
    }
    
    func remoteSync() {
        Task(priority: nil) {
            do {
                let newPeople = try await networkManager.getAllPeople()
                print(newPeople)
                Person.persistNewPeople(people: newPeople)
            } catch {
                print("sync failed")
            }
        }
    }
    
    func pushToDisplayVC() {
        let displayViewController = DisplayViewController()
        
        if let person = personModel {
            displayViewController.setPersonModel(model: person)
            
            if let navigationController = self.navigationController {
                navigationController.pushViewController(displayViewController, animated: true)
            }
        }
    }
}
