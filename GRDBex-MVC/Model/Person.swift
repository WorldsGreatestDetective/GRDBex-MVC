//
//  Person.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation
import GRDB

struct Person: Codable, FetchableRecord, PersistableRecord, PersonModelProtocol {
    var id: String
    var firstName: String
    var lastName: String
    
    static func setid() -> String {
        let identifier: String = UUID().uuidString
        
        return identifier
    }
    
    static func persistNewPerson(person: Person) {
        do {
            try AppDatabase.shared.dbwriter.write({ db in
                try person.insert(db)
            })
        } catch {
            fatalError("error: ")
        }
    }
    
    static func fetchAllPersons() -> [Person] {
        var persons: [Person] = []
        
        do {
            try AppDatabase.shared.dbwriter.read({ db in
                let people = try Person.fetchAll(db)
                
                persons = people
            })
        } catch {
            fatalError("error: ")
        }
        return persons
    }
}
