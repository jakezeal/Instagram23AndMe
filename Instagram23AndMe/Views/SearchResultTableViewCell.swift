//
//  SearchResultTableViewCell.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

protocol SearchResultTableViewCellDelegate: class {
    func didTap(on cell: SearchResultTableViewCell)
}

class SearchResultTableViewCell: UITableViewCell {

    // MARK: - Class Vars
    static let identifier = SearchResultTableViewCell.toString()
    
    // MARK: - Instance Vars
    weak var delegate: SearchResultTableViewCellDelegate?
    var dispatchWorkItem: DispatchWorkItem!
    
    // MARK: - Subviews
    
    
    // MARK: - IBActions
    
    // MARK: - Cell Lifecycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
