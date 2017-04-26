//
//  KeychainHelper.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/26/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private let keychainWrapper = KeychainWrapper()
    
    func setAccessToken(accessToken: String) {
        keychainWrapper.mySetObject(accessToken, forKey: kSecValueData)
        keychainWrapper.writeToKeychain()
    }
    
    func retrieveAccessToken() -> String? {
        let accessToken = keychainWrapper.myObject(forKey: kSecValueData) as? String
        return accessToken == "password" ? nil : accessToken
    }
}
