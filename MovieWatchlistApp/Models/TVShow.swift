//
//  TVShow.swift
//  MovieWatchlistApp
//
//  Created by Dennis Dimitrov on 24.02.22.
//

import UIKit

struct TVShowResponse: Decodable {
    let results: [TVShow]
}

struct TVShow: Decodable {
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
//    let voteCount: Int
//    let runtime: Int
//    var genresIDs: [Int]?
//    var genres: [Genre]?
//    var rating: Double
    var releaseDate: String?
//    var nextEpisodeReleseDate: String?
//    var seasons: Int
//    var episodes: Int
//    var givenRaiting: Int?
//
//    var backdropURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
//    }
//
//    var posterURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
//    }
}

extension TVShowResponse {
    
    static var stubbedSeries: [TVShow] {
        let JSON = """
        {
            "page":1,
            "results": [
                {
                    "backdrop_path":"/qvapa3GAaDj20Lyeuh5NSCaeOfG.jpg",
                    "first_air_date":"2015-07-06",
                    "genre_ids":[18,9648],
                    "id":64000,
                    "name":"Tatlı Küçük Yalancılar",
                    "origin_country":["TR"],
                    "original_language":"tr",
                    "original_name":"Tatlı Küçük Yalancılar",
                    "overview":"Asli, Selin, Ebru, Hande and Açelya are five close friends who live in the same neighborhood and go to the same school. They want to spend a night and watch a movie together at a big country house. However, the group leader Açelya disappears there without leaving anything behind and nobody hears back anything about her. After Açelya's disappearance, they fall apart in order to forget what they have experienced. A year later, the girls begin receiving messages from a mysterious figure named 'A' who threatens to expose their deepest secrets, including the ones they thought only Açelya knew...",
                    "popularity":16.174,
                    "poster_path":"/euDiViLfAFygDMH4LTOQgwpBhvd.jpg",
                    "vote_average":6.5,
                    "vote_count":6
                }
            ],
            "total_pages":2,
            "total_results":27
        }
        """
        let jsonData = JSON.data(using: .utf8)!
        let response: TVShowResponse = try! Utils.jsonDecoder.decode(TVShowResponse.self, from: jsonData)
        return response.results
    }
    
    static var stubbedTVShow: TVShow {
        stubbedSeries[0]
    }
    
}
