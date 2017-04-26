//
//  SearchViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Subviews
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        searchBar.delegate = self
    }
    
    // MARK: - Setups
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return 10 // TODO:
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath)
    
        return cell
    }
}

// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate {
    
}
