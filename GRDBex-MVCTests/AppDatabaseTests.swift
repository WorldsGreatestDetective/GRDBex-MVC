//
//  ModelTests.swift
//  GRDBex-MVCTests
//
//  Created by Nathan Reilly on 1/4/22.
//
// TODO: Write test methods for static methods on Person and any additional db operations
//

import XCTest
import GRDB
@testable import GRDBex_MVC

class AppDatabaseTests: XCTestCase {
    
    var person = Person(id: Person.setid(), firstName: "Joe", lastName: "Shmo")
    
    let personOne = Person(id: Person.setid(), firstName: "Peter", lastName: "Parker")
    let personTwo = Person(id: Person.setid(), firstName: "Bruce", lastName: "Wayne")
    let personThree = Person(id: Person.setid(), firstName: "Clark", lastName: "Kent")

    override func setUpWithError() throws {
        let people = [personOne, personTwo, personThree]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonInsert() throws {
        
        let dbQueue = DatabaseQueue()
        let appDatabase = try! AppDatabase(dbwriter: dbQueue)
        
        try dbQueue.write { db in
            try! person.insert(db)
            try! XCTAssertTrue(person.exists(db))
        }
    }
    
    func testPersonUpdate() throws {
        
        let dbQueue = DatabaseQueue()
        let appDatabase = try! AppDatabase(dbwriter: dbQueue)
        
        try dbQueue.write({ db in
            try! person.insert(db)
            person.lastName = "Deer"
            
            try! person.update(db)
        })
        
        try dbQueue.read({ db in
            let newPerson = try! Person.fetchOne(db, key: person.id)
            
            XCTAssertEqual(person, newPerson)
        })
    }

    /*func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}

/*extension AppDatabase {
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
    }*/

