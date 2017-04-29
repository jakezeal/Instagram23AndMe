//
//  Post.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/26/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation
import SwiftyJSON

enum PostType: String {
    case image = "image"
    case video = "video"
}

struct ImagePost {
    
    // MARK: - Instance Vars
    let imageURLString: String
    
    
    // MARK: - Initializers
    init?(json: JSON) {
        
        guard let type = json["type"].string else { return nil }
        guard type == PostType.image.rawValue else { return nil }
        
        let images = json["images"]
        guard let standardResolutionImageURLString = images["standard_resolution"]["url"].string else { return nil }
        imageURLString = standardResolutionImageURLString
        
    }
}
