//
//  NetworkManager.swift
//  GRDBex-MVC
//
//  Created by Nathan Reilly on 2/12/22.
//
//  TODO: Create and use new token for github
//

import Foundation

struct NetworkManager {
    var httpMethod: HTTPMethod
    var url: String
    var request: URLRequest
    
    let session = URLSession.shared
    
    init(httpMethod: HTTPMethod) {
        self.httpMethod = httpMethod
        
        switch httpMethod {
        case .PUT:
            <#code#> // TODO: Configure .url and .request according to corresponding HTTP method
        case .GET:
            self.url = "http://tsgaerial.com/api/person/read.php"
            self.request = URLRequest(url: URL(string: url)!)
            
            self.request.setValue("*", forHTTPHeaderField: "Access-Control-Allow-Origin")
            self.request.setValue("application/json", forHTTPHeaderField: "Content-type")
        case .POST:
            <#code#>
        case .DELETE:
            <#code#>
        default:
            break
        }
    }
    
    func putNewPerson(person: inout PersonModelProtocol) throws {
        // TODO: - Perhaps ensure .httpMethod is appropiate to func (guard statement?)
        
        let encoder = JSONEncoder()
        let personData = try! encoder.encode(person as? Person)
        
        let task = session.uploadTask(with: request, from: personData)
        task.resume()
    }
    
    func getNewPeople() -> [Person] {
        let decoder = JSONDecoder()
        var people: [Person]
        
        let task = session.dataTask(with: request) { data, response, error in
            do {
                let newPeople = try! decoder.decode([Person].self, from: data!)
                people = newPeople
            } catch {
                print(error)
            }
        }
        task.resume()
        return people
    }
    
    // TODO: Write remaining methods according to CRUD operations
}
