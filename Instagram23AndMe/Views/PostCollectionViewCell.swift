//
//  PostCollectionViewCell.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

protocol PostCollectionViewCellDelegate: class {
    func didTap(likeButton: UIButton, on cell: PostCollectionViewCell)
}

class PostCollectionViewCell: UICollectionViewCell {

    // MARK: - Class Vars
    static let identifier = PostCollectionViewCell.toString()
    
    // MARK: - Instance Vars
    weak var delegate: PostCollectionViewCellDelegate?
//    var dispatchWorkItem: DispatchWorkItem!
    
    // MARK: - Subviews
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTap(likeButton: sender, on: self)
    }
    
    // MARK: - Cell Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        dispatchWorkItem.cancel()
        postImageView.image = nil
    }

}
