//
//  Person.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation
import GRDB

struct Person: PersonModelProtocol, Equatable, Encodable, Decodable {
    var id: String
    var firstName: String
    var lastName: String
    
    static func setid() -> String {
        let identifier: String = UUID().uuidString
        
        return identifier
    }
}

extension Person: PersistableRecord, FetchableRecord { // TODO: Implement stronger error handling for all db transactions
    init(row: Row) {
        id = row["id"]
        firstName = row["firstName"]
        lastName = row["lastName"]
    }
    
    static func persistNewPerson(person: PersonModelProtocol) {
        if let person = person as? Person {
            do {
                try AppDatabase.shared.dbwriter.write({ db in
                    try! person.insert(db)
                })
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    static func fetchAllPeople() -> [PersonModelProtocol] {
        var persons: [Person] = []
        
        do {
            try AppDatabase.shared.dbwriter.read({ db in
                let people = try! Person.fetchAll(db)
                
                persons = people
            })
        } catch {
            fatalError("\(error)")
        }
        return persons
    }
}
