//
//  NewPersonTableViewController.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 1/29/22.
//

import UIKit

class PersonTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var peopleModel: [PersonModelProtocol]?
    var personTableView: PersonTableViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setPeopleModel(people: Person.fetchAllPeople())
        setView()
        configureTableView()
    }
    
    func setPersonTableView(view: PersonTableViewProtocol) {
        personTableView = view
        personTableView!.setController(controller: self)
    }
    
    func setView() {
        let newView = PersonTableView(frame: self.view.frame)
        
        setPersonTableView(view: newView)
        self.view = personTableView as? UIView
    }
    
    func setPeopleModel(people: [PersonModelProtocol]) {
        peopleModel = people
    }
    
    func configureTableView() {
        personTableView!.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        personTableView!.tableView.dataSource = self
        personTableView!.tableView.delegate = self
        personTableView!.tableView.frame = self.view.frame
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let people = peopleModel {
            print(people.count)
            return people.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        
        if let people = peopleModel {
            content.text = "\(people[indexPath.row].firstName) \(people[indexPath.row].lastName)"
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
    /*func numberOfSections(in tableView: UITableView) -> Int {
        
    }*/
}
