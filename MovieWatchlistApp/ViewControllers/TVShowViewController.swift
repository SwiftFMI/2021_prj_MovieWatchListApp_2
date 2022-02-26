//
//  TVShowViewController.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 26.02.22.
//

import UIKit

class TVShowViewController: UIViewController {
    
    var tvShow: TVShow?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = tvShow?.name
        imageView.image = UIImage(data: try! Data(contentsOf: tvShow!.backdropURL))
        overviewLabel.text = tvShow?.overview
    }
    
}
