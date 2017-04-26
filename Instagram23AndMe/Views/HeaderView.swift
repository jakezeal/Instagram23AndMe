//
//  HeaderView.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/24/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func didTap(tagsButton: UIButton, on headerView: HeaderView)
    func didTap(placesButton: UIButton, on headerView: HeaderView)
}

class HeaderView: UIView {
    
    // MARK: - Instance Vars
    internal weak var delegate: HeaderViewDelegate?
    fileprivate var didSetupConstraints = false
    fileprivate var selectedButtonHighlightLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Subviews
    fileprivate lazy var tagsButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.set(button: button, withTitle: "Tags", titleColor: .black)
        
        button.addTarget(self, action: #selector(self.tagsButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var placesButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.set(button: button, withTitle: "Places", titleColor: .black)
        
        button.addTarget(self, action: #selector(self.placesButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    let selectedButtonHighlight: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubviews([tagsButton,
                     placesButton,
                     selectedButtonHighlight,
                     bottomBorder])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func set(button: UIButton, withTitle title: String, titleColor: UIColor) {
        button.setTitle(title, for: .normal)
    }
}

// MARK: - Button Actions

extension HeaderView {
    func tagsButtonTapped() {
        delegate?.didTap(tagsButton: tagsButton, on: self)
    }
    
    func placesButtonTapped() {
        delegate?.didTap(placesButton: placesButton, on: self)
    }
    
    func selectTagsButton() {
        set(button: tagsButton, withTitle: "Tags", titleColor: .black)
        set(button: placesButton, withTitle: "Places", titleColor: .lightGray)
        
        selectedButtonHighlightLeadingConstraint?.constant = 0
    }
    
    func selectActivityButton() {
        set(button: tagsButton, withTitle: "Tags", titleColor: .black)
        set(button: placesButton, withTitle: "Places", titleColor: .lightGray)
        
        selectedButtonHighlightLeadingConstraint.constant = placesButton.frame.minX
    }
}

// MARK: - AutoLayout

extension HeaderView {
    func setupConstraints() {
        // Tags Button
        NSLayoutConstraint.activate([tagsButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     tagsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                                     tagsButton.heightAnchor.constraint(equalToConstant: 46),
                                     tagsButton.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: 0)])
        // Places Button
        NSLayoutConstraint.activate([placesButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     placesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                                     placesButton.heightAnchor.constraint(equalTo: tagsButton.heightAnchor),
                                     placesButton.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: 0)])
    
        // Bottom Border
        NSLayoutConstraint.activate([bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     bottomBorder.heightAnchor.constraint(equalToConstant: 1),
                                     bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        // Selected Button Highlight
        NSLayoutConstraint.activate([selectedButtonHighlight.heightAnchor.constraint(equalToConstant: 2),
                                     selectedButtonHighlight.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
                                     selectedButtonHighlight.bottomAnchor.constraint(equalTo: bottomBorder.topAnchor, constant: 0)])
        selectedButtonHighlightLeadingConstraint = selectedButtonHighlight.leadingAnchor.constraint(equalTo: leadingAnchor)
        selectedButtonHighlightLeadingConstraint.isActive = true

    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            setupConstraints()
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
