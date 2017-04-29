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
    var userId: String
    var username: String
    var fullName: String
    var profilePictureURL: URL?
    
    // MARK: - Initializers
    init(userId: String, username: String, fullName: String) {
        self.userId = userId
        self.username = username
        self.fullName = fullName
    }
}
