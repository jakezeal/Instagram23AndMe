//
//  SearchViewModel.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/26/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class SearchViewModel {

    enum SearchMode {
        case places
        case tags
    }
    
    let places = ["Toronto, San Francisco, Vancouver"]
    let tags = ["puppies, dogs, kittens"]
    
    var filteredPlaces: [String]?
    var filteredTags: [String]?
    
    let searchMode: SearchMode = .places
    
}
