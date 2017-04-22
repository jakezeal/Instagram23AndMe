//
//  User.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class User {
    static var current: User?
    
    // MARK: - Class Methods
    class func set(currentUser: User) {
        current = currentUser
    }
    
    // MARK: - Instance Vars
    var username: String
    
    // MARK: - Initializers
    init(username: String = "mobile23_tester3") {
        self.username = username
    }
}
