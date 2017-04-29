//
//  HomeViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Instance Vars
    let viewModel = HomeViewModel()
    
    // MARK: - Subviews
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchRecentUserPhotos()

    }
    
    // MARK: - Setups
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PostCollectionViewCell.nib(), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    func fetchRecentUserPhotos() {
        viewModel.fetchRecentUserPhotos { [unowned self] (imagePosts) in
            print(imagePosts)
            self.viewModel.imagePosts = imagePosts
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection View Data Source
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagePosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        configure(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    // Configure Cells
    private func configure(_ cell: PostCollectionViewCell, atIndexPath indexPath: IndexPath) {
        
        let imagePost = viewModel.imagePosts[indexPath.row]
        
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

// MARK: - Collection View Delegate
extension HomeViewController: UICollectionViewDelegate {
    
}

// MARK: - Post Collection View Cell Delegate
extension HomeViewController: PostCollectionViewCellDelegate {
    func didTap(likeButton: UIButton, on cell: PostCollectionViewCell) {
        print(#function)
        // Disable button until network call completes
        likeButton.isEnabled = false
        // Get index path of cell
        guard let indexPath = collectionView.indexPathForItem(at: cell.center) else { return }
        // Get ImagePost
        let imagePost = viewModel.imagePosts[indexPath.row]
        
        // Make network request
        viewModel.userLiked(imagePost: imagePost) { (titleString: String) in
            cell.likeButton.setTitle(titleString, for: .normal)
            likeButton.isEnabled = true
        }
        
        
    }
}
