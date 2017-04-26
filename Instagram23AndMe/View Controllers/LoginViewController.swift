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
//        print(urlString)
        
        // Break up into components
        var urlComponents = urlString.components(separatedBy: Constants.Instagram.redirectUri)
        guard urlComponents.count > 1 else { return true }
//        print(urlComponents)
        
        // Access Token
        let accessTokenUrlString = urlComponents[1]

        
        
        guard let accessTokenRange: Range = accessTokenUrlString.range(of: "#access_token="), !accessTokenRange.isEmpty else { return true }
        let accessToken = accessTokenUrlString.substring(from: accessTokenRange.upperBound)
        
        let keychainWrapper = KeychainWrapper()
        keychainWrapper.mySetObject(accessToken, forKey: kSecValueData)
        keychainWrapper.writeToKeychain()
        
        // Save access token to user defaults for later use.
        //                    Add contant key #define KACCESS_TOKEN @”access_token” in contant //class [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey: KACCESS_TOKEN]; [[NSUserDefaults standardUserDefaults] synchronize];
        //                    print("AccessToken = \(strAccessToken) ")
        
        return false
//        guard !accessToken.isEmpty else { return true }
        
        
        
        //            var urlString: String = request.URL!.absoluteString
//            print("URL STRING : \(urlString) ")
//            var UrlParts: [AnyObject] = urlString.componentsSeparatedByString("\"(http://www.clover-studio.com)/")
//            
//            if UrlParts.count > 1 {
//                // do any of the following here
//                urlString = UrlParts[1] as! String
//                let accessToken: NSRange = urlString.rangeOfString("#access_token=")
//                if accessToken.location != NSNotFound {
//                    var strAccessToken: String = urlString.substringFromIndex(urlString.startIndex.advancedBy(NSMaxRange(accessToken)))
//
//                }
//                return false
//            }
//            
//            
//            return true;
        }
    
}
