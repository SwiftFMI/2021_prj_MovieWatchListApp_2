//
//  MovieViewController.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 25.02.22.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movie?.title
        imageView.image = UIImage(data: try! Data(contentsOf: movie!.backdropURL))
        overviewLabel.text = movie?.overview
    }
    
}
