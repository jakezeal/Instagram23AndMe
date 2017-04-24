//
//  HomeViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Subviews
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    // MARK: - Setups
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PostCollectionViewCell.nib(), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
}

// MARK: - Collection View Data Source
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // TODO:
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        cell.delegate = self
        cell.postImageView.image = #imageLiteral(resourceName: "test_image")
        
        return cell
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
