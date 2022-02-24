//
//  Search.swift
//  Watchlist
//
//  Created by Dennis Dimitrov on 23.02.22.
//

import Foundation

protocol SearchResult{
    var page: Int {get set}
    var totalPages: Int {get set}
    var totalResults: Int {get set}
}

struct SearchMovies: SearchResult{
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey{
        case page, results
        case totalPages = "total_pages"
        case totalresults = "total_results"
    }
}


struct SearchSeries: SearchResult{
    var page: Int
    var results: [Series]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey{
        case page, results
        case totalPages = "total_pages"
        case totalresults = "total_results"
    }
}

struct Filters{
    var title: String?
    var genre: String?
    var applied: Bool
}

