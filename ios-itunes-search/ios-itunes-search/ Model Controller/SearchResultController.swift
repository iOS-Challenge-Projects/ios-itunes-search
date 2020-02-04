//
//  SearchResultController.swift
//  ios-itunes-search
//
//  Created by FGT MAC on 2/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/")
    var searchResults: [SearchResult] = []
    
    
    // if the passed-in closure is going to outlive the scope of the method, e.g. if you are saving it to a property, it needs to be annotated with @escaping.
    func performSearch(searchTerm: String, resiltType: ResultType, completition: @escaping () -> Void) {
        
        //Unwraping URL
        guard let baseURL = baseURL else {return}
        
        //Creating a URL component
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //inserting the search + searchTerm to the URL
        let searchTermItems = URLQueryItem(name: "search", value: searchTerm)
   
        //finally we pass the search term to query the API
        urlComponents?.queryItems = [searchTermItems]
        
        guard let requestURL = urlComponents?.url else {
            completition()
            return
        }
    }

    
}
