//
//  ModelTests.swift
//  GRDBex-MVCTests
//
//  Created by Nathan Reilly on 1/4/22.
//

import XCTest
import GRDB
@testable import GRDBex_MVC

class ModelTests: XCTestCase {
    
    let person = Person(id: Person.setid(), firstName: "Joe", lastName: "Shmo")
    
    let personOne = Person(id: Person.setid(), firstName: "Peter", lastName: "Parker")
    let personTwo = Person(id: Person.setid(), firstName: "Bruce", lastName: "Wayne")
    let personThree = Person(id: Person.setid(), firstName: "Clark", lastName: "Kent")

    override func setUpWithError() throws {
        let people = [personOne, personTwo, personThree]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonModelMethods() throws {
        Person.persistNewPerson(person: person)
        
        try AppDatabase.mockShared.dbwriter.read { db in
            let newPerson = try Person.fetchOne(db, key: person.id)
            
            XCTAssertEqual(person, newPerson)
            
            try XCTAssert(newPerson!.delete(db))
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}


extension AppDatabase {
    static let mockShared = mockMakeShared()
    
    static func mockMakeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            
            let folderURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("mockDatabase", isDirectory: true)
            
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            let dbURL = folderURL.appendingPathComponent("mockdb.sqlite")
            let dbPool = try DatabasePool(path: dbURL.path)
            
            let database = try AppDatabase(dbwriter: dbPool)
            
            return database
        } catch {
            fatalError("\(error)")
        }
    }
}
