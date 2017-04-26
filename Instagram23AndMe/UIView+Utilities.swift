//
//  UIView+Utilities.swift
//  humanup
//
//  Created by Chase Wang on 9/19/16.
//  Copyright © 2016 Human Up. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Instance Methods
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
        
        setNeedsUpdateConstraints()
    }
}
