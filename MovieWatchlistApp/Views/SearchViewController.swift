//
//  SearchViewController.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 23.02.22.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        searchController.searchBar.placeholder = "Movies, TV Shows and More"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

