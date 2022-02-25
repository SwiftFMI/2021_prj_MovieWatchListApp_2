//
//  ImageLoader.swift
//  Watchlist
//
//  Created by Dennis Dimitrov on 24.02.22.
//

import SwiftUI
import UIKit

private let imageCache_ = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject{
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache =  imageCache_
    
    func loadImage(with url: URL){
        let urlStr = url.absoluteString
        if let imageFromCache =  imageCache.object(forKey: urlStr as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return}
            do{
                let data  = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else{
                    return
                }
                self.imageCache.setObject(image, forKey: urlStr as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
}


