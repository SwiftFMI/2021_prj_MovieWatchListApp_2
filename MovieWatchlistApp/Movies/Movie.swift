//
//  Movie.swift
//  MovieWatchlistApp
//
//  Created by Dennis Dimitrov on 24.02.22.
//

import Foundation


struct MovieResponse: Decodable{
    
    let res: [Movie]
}

struct Genre: Codable {
    var id: Int
    var name: String
}


struct Movie: Decodable{
    
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
    var givenRaiting: Int?
    
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    
}


extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "movie_list")
        return response!.res
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}

