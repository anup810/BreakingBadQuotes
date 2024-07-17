//
//  FetchService.swift
//  BreakingBadQuotes
//
//  Created by Anup Saud on 2024-07-17.
//

import Foundation
struct FetchService {
    enum FetchError: Error{
        case badResponse
    }
    
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    /*"https://breaking-bad-api-six.vercel.app/api/quotes/random?production = Breaking+ Bad" */
    
    func fetchQuote(from show:String) async throws -> Quote{
        //Build fetch Url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch data
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        //Handle response
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        
        //Decode Data
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        //Return quote
        
        return quote
        
    }
    
    func fetchCharacter(_ name:String) async throws -> Character{
        
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: name, value: name)])
        
        let (data,response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
        
    }
    func fetchDeath(for character: String) async throws -> Death?{
        let fetachURL = baseURL.appending(path: "death")
        
        let (data,response) = try await URLSession.shared.data(from: fetachURL)
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths{
            if death.character == character{
                return death
            }
        }
        return nil
    }
}
