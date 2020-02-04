//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by FGT MAC on 2/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")
    
    var searchResults: [SearchResult] = []
    
    
    // if the passed-in closure is going to outlive the scope of the method, e.g. if you are saving it to a property, it needs to be annotated with @escaping.
    func performSearch(searchTerm: String, resultType: ResultType, completition: @escaping () -> Void) {
        
        //1. Unwraping URL
        guard let baseURL = baseURL else {return}
        
        //2.Creating a URL component
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //3.inserting the search + searchTerm to the URL
//        let searchTermItems = URLQueryItem( name: "term", value: searchTerm)
   
        //4.Pass the search term
        urlComponents?.queryItems = [
         URLQueryItem( name: "term", value: searchTerm),
         URLQueryItem( name: "media", value: resultType.rawValue)
        
        ]
        
        guard let requestURL = urlComponents?.url else {
            print("Contructed URL is nil")
            completition()
            return
        }
        
        //5.if the requestURL is not nil
        var request = URLRequest(url: requestURL)
        
        //6. now we specify what type of HTTP request we are making
        //we could just set it equal to "GET" but to be safe we can use an enum
        request.httpMethod = HTTPMethod.get.rawValue
        
        
  
        //7. Handleling the data/errrors return from ther call
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                print("Error fetching data: \(error)")
                return
            }
            
            //8.unwrap data returned from API
            guard let data = data else{
                print("No data return from API")
                completition()
                return
            }
            
            //creating instance of decoder
            let jsonDecoder = JSONDecoder()
            
            
            //9.Now try the request
            do{
                let itunesSearch = try jsonDecoder.decode(SearchResults.self, from: data)
                
                self.searchResults.append(contentsOf: itunesSearch.results)
            }catch{
                
               print("Unable to decode data into object of type [SearchResult]:\(error)")
            }
            completition()
            
        //10. resume to start the request
        }.resume()
        
    }

    
}
