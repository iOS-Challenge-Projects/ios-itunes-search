//
//  SearchResult.swift
//  ios-itunes-search
//
//  Created by FGT MAC on 2/4/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import Foundation

//Creating the structure to mirror the API structure


struct SearchResult: Codable {
    var title: String
    var creator: String
    
    //Allow us to use a name/key for the property inside the app which is different from the "key" coming from the API
    enum CodingKeys: String, CodingKey {
        //title is the name we want to use in our app = trackName is the key needed to access the value in the API call
        case title = "trackName"
        case creator = "artistName"
    }
    
    
}


struct SearchResults {
    var results: [SearchResult]
}
