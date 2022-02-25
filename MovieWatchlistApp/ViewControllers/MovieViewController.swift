//
//  MovieViewController.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 25.02.22.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movie?.title
    }
    
}
