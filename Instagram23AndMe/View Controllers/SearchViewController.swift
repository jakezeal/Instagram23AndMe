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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSegmentedControl()
    }
    
    // MARK: - Setups
    func setupCollectionView() {
        collectionView.register(PostCollectionViewCell.nib(), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    // MARK: - Helpers
    func longitudeAndLatitudeFromPlace(searchText: String) {
        // TODO: Turn place passed in, into latitude and longitude
    }
    
    func filterPlacesForSearchText(searchText: String) {
        // TODO: Extra - Display list of suggested places based on what are typing
    }
    
    func segmentedControlValueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.searchMode = .places
        case 1:
            viewModel.searchMode = .tags
        default:
            viewModel.searchMode = .places
        }
    }
    
}

// MARK: - Collection View Data Source
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        configure(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    // Configure Cells
    private func configure(_ cell: PostCollectionViewCell, atIndexPath indexPath: IndexPath) {
        
        let imagePost = viewModel.filteredPosts[indexPath.row]
        
        let imageURL = URL(string: imagePost.imageURLString)
        
        cell.postImageView.kf.setImage(with: imageURL, completionHandler: {
            (image, error, cacheType, imageUrl) in
            if let error = error {
                assertionFailure("Error on \(#function): \(error.localizedDescription)")
            }
        })
        
        if imagePost.userHasLiked {
            cell.likeButton.setTitle("Unlike", for: .normal)
        } else {
            cell.likeButton.setTitle("Like", for: .normal)
        }
        
        cell.delegate = self
        
    }
    
}

// MARK: - Post Collection View Cell Delegate
extension SearchViewController: PostCollectionViewCellDelegate {
    func didTap(likeButton: UIButton, on cell: PostCollectionViewCell) {
        print(#function)
        // Disable button until network call completes
        likeButton.isEnabled = false
        // Get index path of cell
        guard let indexPath = collectionView.indexPathForItem(at: cell.center) else { return }
        // Get ImagePost
        let imagePost = viewModel.filteredPosts[indexPath.row]
        
        // Make network request
        viewModel.userLiked(imagePost: imagePost) { (titleString: String) in
            cell.likeButton.setTitle(titleString, for: .normal)
            likeButton.isEnabled = true
        }
        
        
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPlacesForSearchText(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        switch viewModel.searchMode {
        case .places:
            longitudeAndLatitudeFromPlace(searchText: searchText)
            viewModel.searchPlace {
                self.collectionView.reloadData()
            }
        case .tags:
            viewModel.searchTag {
                self.collectionView.reloadData()
            }
        }
        
        //TODO: Resign first responder
    }
}
