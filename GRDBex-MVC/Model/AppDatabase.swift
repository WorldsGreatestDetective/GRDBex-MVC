//
//  AppDatabase.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation
import GRDB

class AppDatabase {
    let dbwriter: DatabaseWriter
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        //migrator.eraseDatabaseOnSchemaChange = true //uncomment when implementing future changes to data models and and want to nuke database 
        
        migrator.registerMigration("schemaChange0") { db in
            try db.create(table: "Person", body: { t in
                t.column("id", .text).primaryKey().notNull(onConflict: nil)
                t.column("firstName", .text).notNull(onConflict: nil)
                t.column("lastName", .text).notNull(onConflict: nil)
            })
        }
        //migrator.registerMigration("schemaChange1", migrate: <#T##(Database) throws -> Void#>)
        
        return migrator
    }
    
    init(dbwriter: DatabaseWriter) throws {
        self.dbwriter = dbwriter
        try migrator.migrate(dbwriter)
    }
    
}
