//
//  NetworkManager.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 2/12/22.
//
//  TODO: Configure .url and .request according to corresponding HTTP method using initializer
//
//  TODO: Recall must remove ATS setting from info.plist after configuring backend to ATS
//

import Foundation

actor NetworkManager {
    var httpMethod: HTTPMethod
    var url: String?
    var request: URLRequest?
    
    let session = URLSession.shared
    
    init(httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod
        self.url = nil
        self.request = nil
        
        switch httpMethod {
        case .PUT:
            print("see TODO")
        case .GET:
            self.url = "http://tsgaerial.com/api/person/read.php"
            self.request = URLRequest(url: URL(string: url!)!)
            
            self.request!.setValue("*", forHTTPHeaderField: "Access-Control-Allow-Origin")
            self.request!.setValue("application/json", forHTTPHeaderField: "Content-type")
        case .POST:
            print("see TODO")
        case .DELETE:
            print("see TODO")
        default:
            break
        }
    }
    
    func putNewPerson(person: inout PersonModelProtocol) async throws {
        // TODO: - Perhaps ensure .httpMethod is appropiate to func (guard statement?)
        
        let encoder = JSONEncoder()
        let personData = try! encoder.encode(person as? Person)
        
        let task = session.uploadTask(with: request!, from: personData)
        task.resume()
    }
    
    func getAllPeople() async -> [PersonModelProtocol] { // FIXME: - Fix concurrency issue with mutating people within completion handler
        
        let decoder = JSONDecoder()
        var people: [Person] = []
        
        do {
            let (data, _) = try! await session.data(for: request!, delegate: nil)
            let newPeople = try! decoder.decode([Person].self, from: data)
            people = newPeople
        } catch {
            fatalError("\(error)")
        }
        
        return people
    }
    
    // TODO: Write remaining methods according to .httpMethod
}
