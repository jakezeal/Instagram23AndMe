//
//  LoginViewModel.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let instagramURL: URL = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.instagram.com"
        urlComponents.path = "/oauth/authorize/"
        let clientIdQuery = URLQueryItem(name: "client_id", value: Constants.Instagram.clientId)
        let redirectUriQuery = URLQueryItem(name: "redirect_uri", value: Constants.Instagram.redirectUri)
        let responseTypeQuery = URLQueryItem(name: "response_type", value: "token")
        urlComponents.queryItems = [clientIdQuery, redirectUriQuery, responseTypeQuery]
        return urlComponents.url!
    }()
    
    func login() {
        let appDelegate 
    }
    
}
