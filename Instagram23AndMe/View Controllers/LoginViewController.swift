//
//  ViewController.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    // MARK: - Instance Vars
    let viewModel = LoginViewModel()
    
    // MARK: - Subviews
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(URLRequest(url: viewModel.instagramURL))
    }
    
}

// http://clover.studio/2016/08/10/instagram-integration-in-ios-application/
extension LoginViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let urlString = request.url?.absoluteString else { return true }
        
        // Break up into components
        var urlComponents = urlString.components(separatedBy: Constants.Instagram.redirectUri)
        guard urlComponents.count > 1 else { return true }
        
        // Access Token
        let accessTokenUrlString = urlComponents[1]
        guard let accessTokenRange: Range = accessTokenUrlString.range(of: "#access_token="), !accessTokenRange.isEmpty else { return true }
        let accessToken = accessTokenUrlString.substring(from: accessTokenRange.upperBound)
        print(accessToken)
        
        // Set Item in Keychain
        KeychainHelper.shared.setAccessToken(accessToken: accessToken)
        
        
        return false
        
    }
    
}
