//
//  SearchViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController {

    // MARK: - Instance Vars
    let viewModel = SearchViewModel()
    
    
    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    // MARK: - Setups
    func setupTableView() {
        
        tableView.register(SearchResultTableViewCell.nib(),
                           forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
    
    // MARK: - Helpers
    func filterPlacesForSearchText(searchText: String, scope: String = "All") {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            viewModel.filteredPlaces = viewModel.places.filter { place in
                return place.lowercased().contains(searchText.lowercased())
            }
            
        } else {
            viewModel.filteredPlaces = viewModel.places
        }
        
    }
    
}

// MARK: - Table View Data Source
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.searchMode {
        case .places:
            if searchController.isActive && searchController.searchBar.text != "" {
                return viewModel.filteredPlaces.count
            }
            
            return viewModel.places.count
        case .tags:
            if searchController.isActive && searchController.searchBar.text != "" {
                return viewModel.filteredTags.count
            }
            return viewModel.tags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath)
    
        return cell
    }
}

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchResultTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchResultTableViewCell.height
    }
}

// MARK: - Search Controller Delegate
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterPlacesForSearchText(searchText: searchText)
    }
}

//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        switch viewModel.searchMode {
//        case .places:
//            if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//                viewModel.filteredPlaces = viewModel.places.filter { place in
//                    return place.lowercased().contains(searchText.lowercased())
//                }
//                
//            } else {
//                viewModel.filteredPlaces = viewModel.places
//            }
//            tableView.reloadData()
//        case .tags:
//            if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//                viewModel.filteredTags = viewModel.places.filter { tag in
//                    return tag.lowercased().contains(searchText.lowercased())
//                }
//                
//            } else {
//                viewModel.filteredTags = viewModel.places
//            }
//            tableView.reloadData()
//        }
//    }
//}
