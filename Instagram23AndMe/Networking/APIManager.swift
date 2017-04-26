//
//  APIManager.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let baseURLString = "https://api.instagram.com/v1"
    
    // MARK: - Singleton
    static let shared = APIManager()
    
    // MARK: - Instance Vars
    private var sessionManager: SessionManager!
    
    // MARK: - Init
    private init() {
        sessionManager = Alamofire.SessionManager.default
    }
    
    func request(route: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(route)
            .validate(statusCode: 200..<300)
    }
}
