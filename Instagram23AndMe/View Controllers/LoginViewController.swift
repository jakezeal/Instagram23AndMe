//
//  ViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Instance Vars
    let viewModel = LoginViewModel()
    
    // MARK: - Subviews
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
//        viewModel.login()

//        UIApplication.shared.open(viewModel.instagramURL, options: [:], completionHandler: nil)

        let safariViewController = viewModel.safariViewController(withURL: viewModel.instagramURL)
        
        present(safariViewController, animated: true, completion: nil)
    }

}

