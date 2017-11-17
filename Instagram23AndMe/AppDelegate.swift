//
//  AppDelegate.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
//        let k = KeychainWrapper()
//        k.resetKeychainItem()
        setupStartViewController()
        
        
        return true
    }
    
    
    
}

// MARK: - Setups
extension AppDelegate {
    func setupStartViewController() {
        
        let startViewController: UIViewController
        
        if let accessToken = KeychainHelper.shared.retrieveAccessToken() {
            // User has access token and has already been authenticated
            print(accessToken)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        } else {
            // User must be authenticated
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            startViewController = storyboard.instantiateInitialViewController() as! LoginViewController
        }
        
        setupWindow(startViewController)
    }

    func setupWindow(_ startViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
    
    func changeRootViewController(_ viewController: UIViewController) {
        
        UIView.transition(with: window!,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: {
                            self.window?.rootViewController = viewController
        }, completion: nil)
        
        window?.makeKeyAndVisible()
    }
}

