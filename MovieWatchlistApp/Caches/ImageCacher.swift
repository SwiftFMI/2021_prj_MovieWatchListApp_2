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
    
    private let session = URLSession.shared
    
    private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .allDomainsMask)[0]
    
    private func components() -> URLComponents {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "image.tmdb.org"
        
        return comp
    }
    
}
