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
        viewModel.fetchRecentUserPhotos { (imagePosts) in
            print(imagePosts)
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
        
        cell.delegate = self
        
    }

}

// MARK: - Collection View Delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Post Collection View Cell Delegate
extension HomeViewController: PostCollectionViewCellDelegate {
    func didTap(likeButton: UIButton, on cell: PostCollectionViewCell) {
        print(#function)
        // TODO: Logic
    }
}
