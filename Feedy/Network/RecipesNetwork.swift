//
//  RecipesNetwork.swift
//  Feedy
//
//  Created by jack Maarek on 04/04/2019.
//  Copyright © 2019 jack Maarek. All rights reserved.
//

import Foundation

class RecipesNetwork {
    typealias completionAlias = ([Recipe]?, NetworkError?) -> Void
    static let baseUrl = "http://192.168.43.126:7689/"
    
    enum NetworkError: Error {
        case malformedUrl(_ error: String)
        case noData(_ error: String)
        case generic(_ error: String)
        case httpCode(_ error: String)
        case jsonParsing(_ error: String)
    }
    
    private static func makeRequest(_ request: URLRequest, completion: @escaping completionAlias) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) {
            data, response, error in
            
            guard let data = data else {
                completion(nil, .noData("No data found"))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .generic("Unparsable HTTP response"))
                return
            }
            
            guard response.statusCode < 300 else {
                completion(nil, .httpCode("Expected 200, Got \(response.statusCode)"))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let recipies = try decoder.decode(Recipes.self, from: data)
                completion(recipies.data, nil)
            } catch let e {
                completion(nil, .jsonParsing("JSON parse error, \(e.localizedDescription)"))
                return
            }
        }
        task.resume()
    }
    
    static func getRecipes(completion: @escaping completionAlias) {
        if let url = URL(string: baseUrl) {
            let request = URLRequest(url: url)
            
            makeRequest(request) {
                recipe, error in
                
                guard nil == error else {
                    completion(nil, error)
                    return
                }
                
                completion(recipe, nil)
            }
        } else {
            completion(nil, .malformedUrl("url \(baseUrl) is incorrect"))
        }
    }
}
