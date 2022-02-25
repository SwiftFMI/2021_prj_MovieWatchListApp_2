//
//  Series.swift
//  MovieWatchlistApp
//
//  Created by Dennis Dimitrov on 24.02.22.
//

import Foundation

struct Series{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    //let voteCount: Int

    let runtime: Int
    var genresIDs: [Int]?
    var genres: [Genre]?
    var rating: Double
    var releaseDate: String?
    var nextEpisodeReleseDate: String?
    var seasons: Int
    var episodes: Int
    var givenRaiting: Int?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}

