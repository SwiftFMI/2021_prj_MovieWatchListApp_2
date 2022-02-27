//
//  ImageCache.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 26.02.22.
//

import UIKit

enum ImageCacheError: Error {
    case badUrl
    case badResponse
    case badData
    case unknownError
}

class ImageCache {
    
    static let shared = ImageCache()
    
    private let fileManager: FileManager
    private let session: URLSession
    private let cacheURL: URL
    
    private init() {
        self.session = URLSession.shared
        self.fileManager = FileManager.default
        self.cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    
    private func components() -> URLComponents {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "image.tmdb.org"
        
        return comp
    }
    
    func movieBackdrop(movie: Movie, completion: @escaping (Result<Data, ImageCacheError>) -> (Void)) {
        guard let backdropPath = movie.backdropPath else {
            completion(.failure(.badUrl))
            return
        }
        
        var comp = components()
        comp.path = "/t/p/w500/" + backdropPath
        downloadImage(imageURL: comp.url!, completion: completion)
    }
    
    private func downloadImage(imageURL: URL, completion: @escaping (Result<Data, ImageCacheError>) -> (Void)) {
        let dstURL = cacheURL.appendingPathComponent(imageURL.lastPathComponent)
        
        if fileManager.fileExists(atPath: dstURL.path) {
            let data = try! Data(contentsOf: dstURL)
            completion(.success(data))
            return
        }
        
        session.downloadTask(with: imageURL) { srcURL, response, error in
            if error != nil {
                completion(.failure(.unknownError))
                return
            }
             
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let srcURL = srcURL else {
                completion(.failure(.badUrl))
                return
            }
            
            guard let data = try? Data(contentsOf: srcURL) else {
                completion(.failure(.badData))
                return
            }
            
            try! self.fileManager.moveItem(at: srcURL, to: dstURL)
            completion(.success(data))
            
        }.resume()
    }
    
}
