//
//  InstagramService.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum PostError: Error {
    case error
}

class InstagramService {
    class func fetchRecentUserPhotos(completionHandler: @escaping (Result<[ImagePost]>) -> Void) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else { return }
        APIManager.shared.request(route: InstagramRouter.fetchRecentUserPhotos(token)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let data = json["data"].array {
                    let posts = data.flatMap(ImagePost.init)
                    completionHandler(.success(posts))
                }
                
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                completionHandler(.failure(error))
            }
        }
    }
    
    class func likePost(withMediaId mediaId: String, completionHandler: @escaping () -> Void) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else { return }
        APIManager.shared.request(route: InstagramRouter.likePost(mediaId, token)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler()
                
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                completionHandler()
            }
        }
    }
    
    class func unlikePost(withMediaId mediaId: String, completionHandler: @escaping () -> Void) {
        guard let token = KeychainHelper.shared.retrieveAccessToken() else { return }
        APIManager.shared.request(route: InstagramRouter.unlikePost(mediaId, token)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                completionHandler()
                
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                completionHandler()
            }
        }
    }
}
