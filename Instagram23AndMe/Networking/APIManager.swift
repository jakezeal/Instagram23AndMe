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
    
    static let baseURLString = "https://humanup.io/api"
    
    // MARK: - Singleton
    static let shared = APIManager()
    
    // MARK: - Instance Vars
    private var sessionManager: SessionManager!
    
    // MARK: - Init
    private init() {
        sessionManager = Alamofire.SessionManager.default
    }
}
