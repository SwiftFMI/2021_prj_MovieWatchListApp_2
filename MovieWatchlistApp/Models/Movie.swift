//
//  Movie.swift
//  MovieWatchlistApp
//
//  Created by Dennis Dimitrov on 24.02.22.
//

import UIKit

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Genre: Decodable {
    var id: Int
    var name: String
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    var genresIDs: [Int]?
    var genres: [Genre]?
    var releaseDate: String?

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}

extension MovieResponse {
    
    static var stubbedMovies: [Movie] {
        let JSON = """
        {
            "results": [
                {
                    "popularity": 29.628,
                    "vote_count": 580,
                    "video": false,
                    "poster_path": "/7ht2IMGynDSVQGvAXhAb83DLET8.jpg",
                    "id": 565310,
                    "adult": false,
                    "backdrop_path": "/qfB3KR6AuRI3Sqz8jWAOpRaGC0H.jpg",
                    "original_language": "en",
                    "original_title": "The Farewell",
                    "genre_ids": [
                        35,
                        18
                    ],
                    "title": "The Farewell",
                    "vote_average": 7.6,
                    "overview": "A headstrong Chinese-American woman returns to China when her beloved grandmother is given a terminal diagnosis. Billi struggles with her family's decision to keep grandma in the dark about her own illness as they all stage an impromptu wedding to see grandma one last time.",
                    "release_date": "2019-07-12"
                }
            ],
            "page": 1,
            "total_results": 655,
            "dates": {
                "maximum": "2020-05-26",
                "minimum": "2020-04-08"
            },
            "total_pages": 33
        }
        """
        let jsonData = JSON.data(using: .utf8)!
        let response: MovieResponse = try! Utils.jsonDecoder.decode(MovieResponse.self, from: jsonData)
        return response.results
//        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
//        return response!.res
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}
