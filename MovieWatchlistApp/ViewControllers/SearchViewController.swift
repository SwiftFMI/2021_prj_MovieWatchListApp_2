//
//  SearchViewController.swift
//  MovieWatchlistApp
//
//  Created by Kaloyan Dimov on 23.02.22.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let store = MovieStore.shared
    
    var movies: [Movie]?
    var tvShows: [TVShow]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Movies, TV Shows and More"
        searchController.searchBar.scopeButtonTitles = ["Movies", "TV Shows"]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex] {
        case "Movies": return movies?.count ?? 0
        case "TV Shows": return tvShows?.count ?? 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex] {
        case "Movies":
            content.text = movies?[indexPath.row].title
            content.secondaryText = movies?[indexPath.row].releaseDate
        case "TV Shows":
            content.text = tvShows?[indexPath.row].name
        default:
            break
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex] {
        case "Movies":
            let movie = movies![indexPath.row]
            performSegue(withIdentifier: "movieSegue", sender: movie)
        case "TV Shows":
            let tvShow = tvShows![indexPath.row]
            performSegue(withIdentifier: "tvShowSegue", sender: tvShow)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "movieSegue") {
            if let nextViewController = segue.destination as? MovieViewController {
                nextViewController.movie = sender as? Movie
            }
        }
        else if (segue.identifier == "tvShowSegue") {
            if let nextViewController = segue.destination as? TVShowViewController {
                nextViewController.tvShow = sender as? TVShow
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex] == "Movies" {
            store.searchMovie(query: text) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.movies = response.results
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        else if searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex] == "TV Shows" {
            store.searchSeries(query: text) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.tvShows = response.results
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        tableView.reloadData()
    }
}
