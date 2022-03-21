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

// MARK: - JSON Decoding Support

extension Person {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try! valueContainer.decode(String.self, forKey: CodingKeys.id)
        self.firstName = try! valueContainer.decode(String.self, forKey: CodingKeys.firstName)
        self.lastName = try! valueContainer.decode(String.self, forKey: CodingKeys.lastName)
    }
}

// MARK: - Record Type Adheherence

extension Person: PersistableRecord, FetchableRecord { // TODO: Implement stronger error handling for all db transactions
    /*init(row: Row) {
        id = row["id"]
        firstName = row["firstName"]
        lastName = row["lastName"]
    }*/
    
    // MARK: - Person Database Transaction Methods
    
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
    
    static func persistNewPeople(people: [PersonModelProtocol]) {
        for person in people {
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
