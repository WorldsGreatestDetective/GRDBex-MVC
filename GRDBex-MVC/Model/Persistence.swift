//
//  Persistence.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 11/2/21.
//

import Foundation
import GRDB

extension AppDatabase {
    static let shared = makeShared()
    
    static func makeShared() -> AppDatabase {
        do {
            let fileManager = FileManager()
            
            let folderURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("database", isDirectory: true)
            
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            let dbURL = folderURL.appendingPathComponent("db.sqlite")
            let dbPool = try DatabasePool(path: dbURL.path)
            
            let database = try AppDatabase(dbwriter: dbPool)
            
            return database
        } catch {
            fatalError("\(error)")
        }
    }
}
