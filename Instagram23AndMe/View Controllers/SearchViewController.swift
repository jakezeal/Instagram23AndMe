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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

//        searchController.searchResultsUpdater = self
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false
//        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    // MARK: - Setups
    func setupTableView() {
        
        tableView.register(SearchResultTableViewCell.nib(),
                           forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
    
}

// MARK: - Table View Data Source
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Change based on whether it is places or tags
        
        switch viewModel.searchMode {
        case .places:
            return 3
        case .tags:
            return 1
        }
        
        
//        return 10 // TODO:
        
//        if (isSearching) {
//            return [filteredContentList count];
//        }
//        else {
//            return [contentList count];
//        }
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

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        switch viewModel.searchMode {
        case .places:
            if let searchText = searchController.searchBar.text, !searchText.isEmpty {
                viewModel.filteredPlaces = viewModel.places.filter { place in
                    return place.lowercased().contains(searchText.lowercased())
                }
                
            } else {
                viewModel.filteredPlaces = viewModel.places
            }
            tableView.reloadData()
        case .tags:
            if let searchText = searchController.searchBar.text, !searchText.isEmpty {
                viewModel.filteredTags = viewModel.places.filter { tag in
                    return tag.lowercased().contains(searchText.lowercased())
                }
                
            } else {
                viewModel.filteredTags = viewModel.places
            }
            tableView.reloadData()
        }
    }
}
